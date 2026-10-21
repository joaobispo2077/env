# Starts windows/ai-memory-http-proxy.py on 127.0.0.1:49374 if nothing is listening.
# The container is published on 127.0.0.1:49375. Agents and hooks stay on 49374.

$ErrorActionPreference = "Stop"
$ListenPort = 49374
$Python = "C:\Python311\python.exe"
$Script = Join-Path $PSScriptRoot "ai-memory-http-proxy.py"

function Test-AiMemoryProxyPort {
    $client = New-Object System.Net.Sockets.TcpClient
    try {
        $wait = $client.BeginConnect("127.0.0.1", $ListenPort, $null, $null)
        $ok = $wait.AsyncWaitHandle.WaitOne(400) -and $client.Connected
        return [bool]$ok
    } catch {
        return $false
    } finally {
        $client.Close()
    }
}

if (Test-AiMemoryProxyPort) { exit 0 }
if (-not (Test-Path $Python)) { throw "Python 3.11 is required at $Python" }

Start-Process -FilePath $Python -ArgumentList @($Script) -WindowStyle Hidden | Out-Null
$deadline = (Get-Date).AddSeconds(8)
do {
    Start-Sleep -Milliseconds 200
    if (Test-AiMemoryProxyPort) { exit 0 }
} while ((Get-Date) -lt $deadline)
throw "ai-memory HTTP proxy did not start listening on 127.0.0.1:$ListenPort"
