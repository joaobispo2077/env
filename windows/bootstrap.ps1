# Store initial time
$initialTime = date

# Install package manager chocolatey - https://chocolatey.org/install
echo "Installing chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Basic apps
echo "Installing basic apps (navigator, read pdf, talk, useful tools)..."
choco install opera-gx vlc adobereader discord lightshot notion brave firefox -y

# Media content apps
echo "Installing media content apps (video & image creation)..."
choco install obs-studio 4k-video-downloader gimp photogimp -y

# Fun apps
echo "Installing fun apps (gaming)..."
choco install steam cemu -y

# Optinal benchmark tools
# echo "Installing benchmark tools..."
# choco install msiafterburner crystaldiskinfo heaven-benchmark -y

# Dev tools
echo "Dev tools basic apps (navigator, useful tools)..."
choco install gh jetbrainsmono git microsoft-windows-terminal tldr vscode vscode-settingssync nvm pyenv-win figma insomnia-rest-api-client beekeeper-studio dbeaver docker-desktop -y

# Show initial and final time of execution
echo "Started at:"
echo $initialTime
echo "Ended at"
date

# Refresh environment variables from PATH
refreshenv
