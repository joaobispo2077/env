# Store initial time

$initialTime = date

# Install package manager chocolatey - https://chocolatey.org/install
echo "Installing chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Basic apps
echo "Installing basic apps (navigator, useful tools)..."
choco install opera-gx adobereader discord lightshot notion brave firefox steam -y

# Optinal benchmark tools
# echo "Installing benchmark tools..."
# choco install msiafterburner crystaldiskinfo heaven-benchmark -y

# Dev tools
echo "Dev tools basic apps (navigator, useful tools)..."
choco install git vscode figma insomnia-rest-api-client beekeeper-studio dbeaver nvm pyenv-win microsoft-windows-terminal jetbrainsmono -y

# Show initial and final time of execution
echo "Started at:"
echo $initialTime
echo "Ended at"
date

# Refresh environment variables from PATH
refreshenv
