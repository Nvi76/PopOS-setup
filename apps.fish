#!/usr/bin/env fish

# Update system
sudo nala update; or exit 1
sudo nala upgrade -y; or exit 1

# Import Brave keyring
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg; or exit 1

# Add Brave repo
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
| sudo tee /etc/apt/sources.list.d/brave-browser-release.list >/dev/null; or exit 1

# Download VS Code
curl -fL \
https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 \
-o vscode.deb; or exit 1

# Ensure gpg exists
sudo nala install -y gnupg; or exit 1

# Import VSCodium keyring
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
| gpg --dearmor \
| sudo tee /usr/share/keyrings/vscodium-archive-keyring.gpg >/dev/null; or exit 1

# Add VSCodium repo
printf "Types: deb
URIs: https://download.vscodium.com/debs
Suites: vscodium
Components: main
Architectures: amd64 arm64
Signed-by: /usr/share/keyrings/vscodium-archive-keyring.gpg
" | sudo tee /etc/apt/sources.list.d/vscodium.sources >/dev/null; or exit 1

# Update after repos
sudo nala update; or exit 1
sudo nala upgrade -y; or exit 1

# Progress
figlet "30% Complete" 2>/dev/null; or echo "30% Complete"

# Ensure Flathub exists
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak apps
flatpak install flathub \
com.rtosta.zapzap \
org.kde.krita \
org.gimp.GIMP \
--noninteractive; or exit 1

# 50%
figlet "50% Complete" 2>/dev/null; or echo "50% Complete"

# Install packages
sudo nala install \
cava \
codium \
pipx \
brave-browser \
-y; or exit 1

# Install VS Code
sudo nala install ./vscode.deb -y; or exit 1

# Cleanup
rm -f vscode.deb

# Final update
sudo nala update; or exit 1
sudo nala upgrade -y; or exit 1

# Homebrew apps
if type -q brew
    brew install neovim thefuck fzf ranger btop trash-cli
end

# Done
figlet "Setup Complete Enjoy Your PC" 2>/dev/null; or echo "Setup Complete Enjoy Your PC"
