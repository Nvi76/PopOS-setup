#!/bin/bash

set -euo pipefail

# Updates the system
sudo nala update -y && sudo nala upgrade -y

# Importing brave browser's repo
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list 

# Downloading vscode 
curl https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 --output vscode.deb

# Importing vscodium's repo
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

# Importing vscodium's repo 
echo -e 'Types: deb\nURIs: https://download.vscodium.com/debs\nSuites: vscodium\nComponents: main\nArchitectures: amd64 arm64\nSigned-by: /usr/share/keyrings/vscodium-archive-keyring.gpg' \
| sudo tee /etc/apt/sources.list.d/vscodium.sources

# Updates the system
sudo nala update -y && sudo nala upgrade -y

# 30%
figlet 30% Complete

# Installing deb apps 
sudo nala install codium brave-browser -y && cd  ~/Downloads && sudo nala install ./vscode.deb

# 65%
figlet 65% Complete

# Installing flatpak apps
flatpak install flathub com.rtosta.zapzap   --noninteractive

# 85%
figlet 85% Complete

# Installing Homebrew packages (make sure to have homebrew already installed)
brew install gcc thefuck fzf ranger mailsy 

# 100%
figlet 100% Complete
