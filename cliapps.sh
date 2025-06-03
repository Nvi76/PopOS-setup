#!/bin/bash 

set -euo pipefail

# Installing essential packages
sudo apt install build-essential nala -y

# Installing Atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# Installing Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 

# Following Homebrews' instructions
sudo apt-get install build-essential -y

# Following Homebrews' instructions
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
