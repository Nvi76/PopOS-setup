#!/usr/bin/env fish

# Update ClamAV
sudo freshclam

# Update system
sudo nala update -y
and sudo nala upgrade -y

# Update Flatpak apps
flatpak update -y

# Update Homebrew
brew update
and brew upgrade

# Update complete
figlet All Update Completed
