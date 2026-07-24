#!/bin/bash

set -e

echo "=== Updating system ==="
sudo apt update && sudo apt upgrade -y

echo "=== Installing dependencies ==="
sudo apt install -y fish curl wget unzip git

echo "=== Installing Oh My Posh ==="
curl -s https://ohmyposh.dev/install.sh | bash -s

# Move oh-my-posh if installed locally
if [ -f "$HOME/.local/bin/oh-my-posh" ]; then
    sudo mv "$HOME/.local/bin/oh-my-posh" /usr/local/bin/
fi

echo "=== Adding Oh My Posh to PATH ==="
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.profile

echo "=== Installing Fish shell ==="
sudo apt install -y fish

echo "=== Setting Fish as default shell ==="
FISH_PATH=$(which fish)
sudo chsh -s "$FISH_PATH" "$USER"

echo "=== Creating Fish configuration ==="

mkdir -p ~/.config/fish

cat > ~/.config/fish/config.fish <<'EOF'

# Disable Fish greeting
set fish_greeting

# Oh My Posh initialization
oh-my-posh init fish --config ~/.cache/oh-my-posh/themes/hul10.omp.json | source

EOF


echo "=== Installing Oh My Posh themes ==="

mkdir -p ~/.cache/oh-my-posh/themes

oh-my-posh get shell fish

# Download hul10 theme
wget -q https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/hul10.omp.json \
-O ~/.cache/oh-my-posh/themes/hul10.omp.json


echo "=== Removing Fish welcome message ==="

echo "set fish_greeting" >> ~/.config/fish/config.fish


echo "=== Setting Fish as login shell ==="
echo "Your default shell is now Fish."

echo ""
echo "Installation completed!"
echo "Restart your terminal or logout/login."
echo "Theme: hul10"
