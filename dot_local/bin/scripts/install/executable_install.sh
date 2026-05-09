#!/bin/bash

set -euo pipefail
trap 'echo -e "${RED}Script failed at line $LINERO${NC}"; exit 1' ERR

sudo -v
# Keep sudo alive throughout script
while true; do
    sudo -n true
    sleep 60
    kill -0 $$ || exit
done 2>/dev/null &

BLACK='\033[1;30m'       # Black
RED='\033[1;31m'         # Red
GREEN='\033[1;32m'       # Green
YELLOW='\033[1;33m'      # Yellow
BLUE='\033[1;34m'        # Blue
PURPLE='\033[1;35m'      # Purple
CYAN='\033[1;36m'        # Cyan
WHITE='\033[1;37m'       # White
NC='\033[0m'             # Color reset

section() {
    echo -e "\n${1}==> ${2}${NC}\n"
}

section "$BLUE" "Preparing..."
sudo pacman -S --needed --noconfirm git curl chezmoi
rm -rf "$HOME/.zshenv" "$HOME/.config/" "$HOME/.local/" "$HOME/Pictures/"

section "$BLUE" "Git setup"
read -p "Enter your username: " GITHUB_USERNAME
read -p "Enter your email: " GITHUB_EMAIL
git config --global user.name "$GITHUB_USERNAME"
git config --global user.email "$GITHUB_EMAIL"
git config --global color.ui auto
git config --global init.defaultBranch main
git config --global pull.rebase false

section "$BLUE" "Copying dotfiles..."
chezmoi init --apply "$GITHUB_USERNAME"

section "$BLUE" "Installing packages..."
sudo pacman -S --needed - < "$HOME/.local/bin/scripts/install/software"

section "$BLUE" "Switching to Zsh..."
if [ -f /bin/zsh ]; then
    chsh -s /bin/zsh
fi

section "$BLUE" "Installing Zsh plugins..."
"$HOME/.config/zsh/plugins/installplugins.sh"

section "$BLUE" "Generating ssh key..."
ssh-keygen -t ed25519 -C "$GITHUB_EMAIL"

section "$BLUE" "Installing mise..."
curl https://mise.run | MISE_INSTALL_PATH=~/.local/bin/mise sh

section "$BLUE" "Installing yay..."
sudo pacman -Syy --needed archlinux-keyring git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ..
rm -rf "$HOME/yay"

section "$BLUE" "Installing AUR packages..."
/usr/bin/yay -S python-pywalfox

section "$BLUE" "Enabling services..."
systemctl --user enable dms
systemctl --user enable mpd-mpris
sudo systemctl enable sddm.service

section "$BLUE" "Finishing touches..."
rm -rf "$HOME/.npm"
rm -f "$HOME/.bashrc"
rm -f "$HOME/.bash_history"
rm -f "$HOME/.bash_profile"
rm -f "$HOME/.bash_login"
rm -f "$HOME/.bash_logout"
rm -f "$HOME/.profile"

mkdir -pv "$HOME/Documents"
mkdir -pv "$HOME/Downloads"
mkdir -pv "$HOME/Music"
mkdir -pv "$HOME/Pictures/screenshots"
mkdir -pv "$HOME/Projects"
mkdir -pv "$HOME/Videos"

mkdir -pv "$HOME/.config/git"
mv -v "$HOME/.gitconfig" "$HOME/.config/git/config"

mkdir -pv "$HOME/.cache/zsh"
touch "$HOME/.cache/zsh/history"

mkdir -pv "$HOME/.local/state/mpd/playlists"
touch "$HOME/.local/state/mpd/pid"

sudo chattr +i "$HOME/.config/qView/qView.conf"

section "$GREEN" "Installation Complete!"
echo -e "${CYAN}You can now reboot your system.${NC}\n"
