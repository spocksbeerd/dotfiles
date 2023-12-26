#!/bin/bash

BLACK='\033[1;30m'       # Black
RED='\033[1;31m'         # Red
GREEN='\033[1;32m'       # Green
YELLOW='\033[1;33m'      # Yellow
BLUE='\033[1;34m'        # Blue
PURPLE='\033[1;35m'      # Purple
CYAN='\033[1;36m'        # Cyan
WHITE='\033[1;37m'       # White
NC='\033[0m'             # Color reset

mkdir -p $HOME/.cache/zsh
touch $HOME/.cache/zsh/history

sudo pacman -Syy --needed archlinux-keyring

# yay
echo -e "${GREEN}+${WHITE} Installing yay...${NC}"
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git $HOME/yay && cd yay && makepkg -si

# configure dotfiles
echo -e "${GREEN}+${WHITE} Copying dotfiles...${NC}"
git clone --bare github.com/spocksbeerd/dotfiles $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout

echo -e "${GREEN}+${WHITE} Installing zsh plugins...${NC}"
$HOME/.config/zsh/plugins/installplugins.sh

# software
echo -e "${GREEN}+${WHITE} Installing software...${NC}"
yay -S --needed - < $HOME/.local/bin/configure/software

# bluetooth 
echo -e "${WHITE}Do you want to install bluetooth support? [y/n]${NC}"
read bluetooth

if [ "$bluetooth" = "y" ]; then
    yay -S --needed bluez bluez-utils
    echo 'systemctl start bluetooth.service' >> $HOME/.cache/zsh/history
fi

# nvidia 
echo -e "${WHITE}Do you want to install nvidia and gwe? [y/n]${NC}"
read nvidia

if [ "$nvidia" = "y" ]; then
    yay -S --needed dkms linux-lts-headers nvidia-dkms gwe
    mkdir -p $HOME/.cache/nvidia
fi

# node
echo -e "${GREEN}+${WHITE} Installing nvm and the latest node version...${NC}"
git clone https://github.com/nvm-sh/nvm.git $HOME/.local/share/nvm
export NVM_DIR=~/.local/share/nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install node

# java
echo -e "${WHITE}Do you want to install java? [y/n]${NC}"
read java

if [ "$java" = "y" ]; then
    yay -S --needed jdk17-openjdk intellij-idea-community-edition 
fi

# laptop specific
echo -e "${WHITE}Are you on the laptop? [y/n]${NC}"
read laptop

if [ "$laptop" = "y" ]; then
    echo -e "${GREEN}+${WHITE} Copying laptop specific xorg configs...${NC}"
    sudo mkdir -p /etc/X11/xorg.conf.d
    sudo cp -r $HOME/.local/bin/configure/laptop/* /etc/X11/xorg.conf.d

    echo -e "${GREEN}+${WHITE} Installing brightnessctl...${NC}"
    yay brightnessctl
fi

# cleanup
echo -e "${GREEN}+${WHITE} Removing the yay repository from the home directory...${NC}"
rm -rf $HOME/yay

echo "Finished. Don't forget about setting up git and the github ssh key"
