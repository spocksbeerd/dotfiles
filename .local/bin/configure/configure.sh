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
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

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

# setting up git
echo -e "${GREEN}+${WHITE} Git setup${NC}"
echo -e "${WHITE}Enter your username:${NC}"
read name
echo -e "${WHITE}Enter your email:${NC}"
read email

git config --global user.name "$name"
git config --global user.email "$email"
git config --global color.ui auto
git config --global init.defaultBranch main
git config --global pull.rebase false


# generating an SSH key
ssh-keygen -t ed25519 -C "$email"

# cleanup
echo -e "${GREEN}+${WHITE} Cleaning up...${NC}"
rm -rf $HOME/yay
mkdir -p $HOME/.config/git
mv $HOME/.gitconfig $HOME/.config/git/config
rm -f $HOME/.bashrc
rm -f $HOME/.bash_profile
rm -f $HOME/.bash_login
rm -f $HOME/.bash_logout
rm -f $HOME/.profile

echo -e "${BLUE}Don't forget to add the SSH key to your github account.${NC}"
echo -e "${BLUE}You can now reboot.${NC}"
