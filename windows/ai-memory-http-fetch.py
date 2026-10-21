"""Read one HTTP request from stdin, fetch it from the published ai-memory port, write the raw response to stdout.

Kept in its own process so Docker Desktop's port proxy cannot rewrite the
listener's later socket writes.
"""

import socket
import sys

MAX_BYTES = 8 * 1024 * 1024
UPSTREAM = ("127.0.0.1", 49375)

request = sys.stdin.buffer.read(MAX_BYTES)
upstream = socket.create_connection(UPSTREAM, 10)
try:
    upstream.sendall(request)
    upstream.settimeout(170)
    data = b""
    while len(data) < MAX_BYTES:
        try:
            chunk = upstream.recv(65536)
        except socket.timeout:
            break
        if not chunk:
            break
        data += chunk
finally:
    upstream.close()
sys.stdout.buffer.write(data)
