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

sudo pacman -S --needed git

git config --global user.name "$name"
git config --global user.email "$email"
git config --global color.ui auto
git config --global init.defaultBranch main
git config --global pull.rebase false

# SSH key
echo ""
echo -e "${GREEN}===${WHITE} GENERATING SSH KEY ${GREEN}===${NC}"
echo ""
ssh-keygen -t ed25519 -C "$email"

# dotfiles
echo ""
echo -e "${GREEN}===${WHITE} COPYING DOTFILES ${GREEN}===${NC}"
echo ""
git clone --bare https://github.com/spocksbeerd/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
cp -f $HOME/.config/dotfilesgitconfig $HOME/.dotfiles/config

echo ""
echo -e "${GREEN}===${WHITE} INSTALLING ZSH PLUGINS ${GREEN}===${NC}"
echo ""
$HOME/.config/zsh/plugins/installplugins.sh

# yay
echo ""
echo -e "${GREEN}===${WHITE} INSTALLING YAY ${GREEN}===${NC}"
echo ""
sudo pacman -Syy --needed archlinux-keyring git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# software
echo ""
echo -e "${GREEN}===${WHITE} INSTALLING SOFTWARE ${GREEN}===${NC}"
echo ""
yay -S --needed - < $HOME/.local/bin/install/software

# node
git clone https://github.com/nvm-sh/nvm.git $HOME/.local/share/nvm
export NVM_DIR=~/.local/share/nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install node

# change shell
if [ -f /bin/zsh ]; then
    echo ""
    echo -e "${GREEN}===${WHITE} CHANGING SHELL ${GREEN}===${NC}"
    echo ""
    chsh -s /bin/zsh
fi

# finishing touches 
echo ""
echo -e "${GREEN}===${WHITE} FINISHING TOUCHES ${GREEN}===${NC}"
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

mkdir -pv $HOME/.cache/zsh
touch $HOME/.cache/zsh/history

# list of useful commands for zsh history
echo "pacman -Qe | cut -d' ' -f1 > installed" >> $HOME/.cache/zsh/history
echo "pacman -Syy --needed archlinux-keyring" >> $HOME/.cache/zsh/history
echo 'gh auth login' >> $HOME/.cache/zsh/history

echo "10000 pcmanfm-qt.desktop" > $HOME/.cache/rofi3.druncache

# make the qview configuration immutable
sudo chattr +i $HOME/.config/qView/qView.conf

# laptop specific
sudo mkdir -pv /etc/X11/xorg.conf.d
sudo cp -rv $HOME/.local/bin/configure/laptop/* /etc/X11/xorg.conf.d

echo ""
echo -e "${BLUE}Done.${NC}"
echo -e "${BLUE}Don't forget to login to github using github cli (gh auth login)${NC}"
echo -e "${BLUE}You can now reboot.${NC}"
