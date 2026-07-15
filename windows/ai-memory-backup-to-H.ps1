$ErrorActionPreference = "Stop"

$source = "C:\ai-memory-data"
$target = "H:\ai-memory-data"
$composeDir = "C:\Users\vitor\dev\tools\env"

Push-Location $composeDir
try {
  docker compose stop ai-memory | Out-Null
  robocopy $source $target /MIR /XD logs models raw /R:2 /W:2 | Out-Host
  $code = $LASTEXITCODE
  docker compose up -d ai-memory | Out-Null

  if ($code -gt 7) {
    throw "robocopy failed with exit code $code"
  }

  "ai-memory brain (auth+db+wiki) mirrored from $source to $target"
}
finally {
  Pop-Location
}
