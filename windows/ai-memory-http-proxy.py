"""Forward 127.0.0.1:49374 to Docker's published ai-memory port 49375.

Docker Desktop advertises Transfer-Encoding: chunked and then writes the raw
body. It also rewrites later socket writes in any process that read that
port. A short-lived child process talks to Docker. This process never opens
49375, so the repaired Content-Length response reaches MCP and hook clients.
Loopback only.
"""

import os
import subprocess
import sys
import socket
import threading

LISTEN = ("127.0.0.1", 49374)


def recv_until(sock, marker, limit):
    data = b""
    while marker not in data and len(data) < limit:
        chunk = sock.recv(4096)
        if not chunk:
            break
        data += chunk
    return data


def header_int(head, name):
    prefix = name + b":"
    for line in head.split(b"\r\n"):
        if line.lower().startswith(prefix):
            try:
                return int(line.split(b":", 1)[1].strip())
            except ValueError:
                return -1
    return -1


def read_request(sock):
    data = recv_until(sock, b"\r\n\r\n", 64 * 1024)
    if b"\r\n\r\n" not in data:
        return data
    head, rest = data.split(b"\r\n\r\n", 1)
    if b"expect:" in head.lower() and b"100-continue" in head.lower():
        sock.sendall(b"HTTP/1.1 100 Continue\r\n\r\n")
    length = header_int(head, b"content-length")
    if length < 0:
        length = 0
    while len(rest) < length:
        chunk = sock.recv(min(65536, length - len(rest)))
        if not chunk:
            break
        rest += chunk
    lines = [
        line
        for line in head.split(b"\r\n")
        if line
        and not line.lower().startswith(b"connection:")
        and not line.lower().startswith(b"expect:")
    ]
    return b"\r\n".join(lines) + b"\r\nConnection: close\r\n\r\n" + rest[:length]


def fetch_upstream(request):
    fetch_script = os.path.join(os.path.dirname(__file__), "ai-memory-http-fetch.py")
    proc = subprocess.run(
        [sys.executable, fetch_script],
        input=request,
        capture_output=True,
        timeout=180,
    )
    if proc.returncode != 0 or not proc.stdout:
        detail = proc.stderr.decode("utf-8", "replace").strip() or "upstream failed"
        body = detail.encode("utf-8")[:300]
        return (
            b"HTTP/1.1 502 Bad Gateway\r\nContent-Type: text/plain\r\nContent-Length: "
            + str(len(body)).encode("ascii")
            + b"\r\nConnection: close\r\n\r\n"
            + body
        )
    return proc.stdout


def repair(raw):
    marker = b"\r\n\r\n"
    split = raw.find(marker)
    if split < 0:
        return raw
    head = raw[:split]
    body = raw[split + len(marker) :]
    lines = []
    for line in head.split(b"\r\n"):
        low = line.lower()
        if low.startswith(
            (b"transfer-encoding:", b"content-length:", b"connection:")
        ):
            continue
        lines.append(line)
    lines.append(b"Transfer-Encoding: chunked")
    lines.append(b"Connection: close")
    chunked = format(len(body), "x").encode("ascii") + b"\r\n" + body + b"\r\n0\r\n\r\n"
    return b"\r\n".join(lines) + marker + chunked


def handle(client):
    try:
        try:
            client.set_inheritable(False)
        except OSError:
            pass
        request = read_request(client)
        if not request:
            return
        client.sendall(repair(fetch_upstream(request)))
    except (OSError, subprocess.TimeoutExpired):
        return
    finally:
        client.close()


def serve():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind(LISTEN)
    server.listen(64)
    while True:
        client, _ = server.accept()
        try:
            client.set_inheritable(False)
        except OSError:
            pass
        threading.Thread(target=handle, args=(client,), daemon=True).start()


if __name__ == "__main__":
    serve()
