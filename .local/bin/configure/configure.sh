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

# git setup
echo ""
echo -e "${GREEN}===${WHITE} GIT SETUP ${GREEN}===${NC}"
echo ""

echo -e "${WHITE}Enter your username:${NC}"
read name
echo -e "${WHITE}Enter your email:${NC}"
read email

git config --global user.name "$name"
git config --global user.email "$email"
git config --global color.ui auto
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global credential.useHttpPath true

echo -e "${WHITE}Are you on the laptop? [y/n]${NC}"
read laptop

echo -e "${WHITE}Do you need bluetooth support? [y/n]${NC}"
read bluetooth

echo -e "${WHITE}Do you want to install nvidia and gwe? [y/n]${NC}"
read nvidia

echo -e "${WHITE}Do you want to install java? [y/n]${NC}"
read java

echo -e "${WHITE}Do you want to install node? [y/n]${NC}"
read node

#software list
curl https://raw.githubusercontent.com/spocksbeerd/dotfiles/main/.local/bin/configure/software --output $HOME/software
list=$HOME/software

# dotfiles
echo ""
echo -e "${GREEN}===${WHITE} COPYING DOTFILES ${GREEN}===${NC}"
echo ""
git clone --bare https://github.com/spocksbeerd/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

echo ""
echo -e "${GREEN}===${WHITE} INSTALLING ZSH PLUGINS ${GREEN}===${NC}"
echo ""
$HOME/.config/zsh/plugins/installplugins.sh

# laptop specific
if [ "$laptop" = "y" ]; then
    echo 'brightnessctl' >> $list
    sudo mkdir -pv /etc/X11/xorg.conf.d
    sudo cp -rv $HOME/.local/bin/configure/laptop/* /etc/X11/xorg.conf.d
fi

# bluetooth 
if [ "$bluetooth" = "y" ]; then
    echo 'bluez' >> $list
    echo 'bluez-utils' >> $list
    mkdir -pv $HOME/.cache/zsh
    echo 'systemctl start bluetooth.service' >> $HOME/.cache/zsh/history
fi

# nvidia 
if [ "$nvidia" = "y" ]; then
    echo 'dkms' >> $list
    echo 'linux-lts-headers' >> $list
    echo 'nvidia-dkms' >> $list
    echo 'gwe' >> $list
    mkdir -pv $HOME/.cache/nvidia
fi

# java
if [ "$java" = "y" ]; then
    echo 'jdk17-openjdk' >> $list
    echo 'intellij-idea-community-edition' >> $list
fi

# yay
echo ""
echo -e "${GREEN}===${WHITE} INSTALLING YAY ${GREEN}===${NC}"
echo ""
sudo pacman -Syy --needed archlinux-keyring git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# software
echo ""
echo -e "${GREEN}===${WHITE} INSTALLING SOFTWARE ${GREEN}===${NC}"
echo ""
yay -S --needed - < $list

# node
if [ "$node" = "y" ]; then
    echo ""
    echo -e "${GREEN}===${WHITE} INSTALLING NVM AND NODE ${GREEN}===${NC}"
    echo ""
    git clone https://github.com/nvm-sh/nvm.git $HOME/.local/share/nvm
    export NVM_DIR=~/.local/share/nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm install node
fi

# SSH key
echo ""
echo -e "${GREEN}===${WHITE} GENERATING SSH KEY ${GREEN}===${NC}"
echo ""
ssh-keygen -t ed25519 -C "$email"

# change shell
if [ -f /bin/zsh ]; then
    echo ""
    echo -e "BASH ${RED}->${NC} ZSH"
    chsh -s /bin/zsh
fi

# finishing touches 
echo ""
echo -e "${GREEN}===${WHITE} CLEANING UP THE HOME FOLDER ${GREEN}===${NC}"
echo ""
rm -rf $HOME/yay
echo "removed /home/yay"
rm -rf $HOME/.npm
echo "removed /home/.npm"
rm -f $HOME/.bashrc
echo "removed /home/.bashrc"
rm -f $HOME/.bash_history
echo "removed /home/.bash_history"
rm -f $HOME/.bash_profile
echo "removed /home/bash_profile"
rm -f $HOME/.bash_login
echo "removed /home/.bash_login"
rm -f $HOME/.bash_logout
echo "removed /home/.bash_logout"
rm -f $HOME/.profile
echo "removed /home/.profile"
rm -f $HOME/software
echo "removed /home/software"
mkdir -pv $HOME/.config/git
mv -v $HOME/.gitconfig $HOME/.config/git/config

echo -e "${BLUE}Done.${NC}"
echo -e "${BLUE}Don't forget to add the SSH key to your github account.${NC}"
echo -e "${BLUE}You can now reboot.${NC}"
