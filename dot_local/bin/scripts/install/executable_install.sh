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

sudo pacman -S --needed --noconfirm git

# dotfiles
echo ""
echo -e "${GREEN}===${WHITE} COPYING DOTFILES ${GREEN}===${NC}"
echo ""
git clone --bare https://github.com/spocksbeerd/dotfiles-wayland.git $HOME/.local/share/dotfiles
git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME checkout

sleep 5

echo ""
echo -e "${GREEN}===${WHITE} INSTALLING ZSH PLUGINS ${GREEN}===${NC}"
echo ""
$HOME/.config/zsh/plugins/installplugins.sh

# software
echo ""
echo -e "${GREEN}===${WHITE} INSTALLING SOFTWARE ${GREEN}===${NC}"
echo ""
sudo pacman -S --needed - < $HOME/.local/bin/install/software

# change shell
if [ -f /bin/zsh ]; then
    echo ""
    echo -e "${GREEN}===${WHITE} CHANGING SHELL ${GREEN}===${NC}"
    echo ""
    chsh -s /bin/zsh
fi

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

# SSH key
echo ""
echo -e "${GREEN}===${WHITE} GENERATING SSH KEY ${GREEN}===${NC}"
echo ""
ssh-keygen -t ed25519 -C "$email"

# finishing touches 
echo ""
echo -e "${GREEN}===${WHITE} FINISHING TOUCHES ${GREEN}===${NC}"
echo ""
rm -rf $HOME/.npm
echo "removed /home/.npm"
rm -f $HOME/.bashrc
echo "removed /home/.bashrc"
rm -f $HOME/.bash_history
echo "removed /home/.bash_history"
rm -f $HOME/.bash_profile
echo "removed /home/.bash_profile"
rm -f $HOME/.bash_login
echo "removed /home/.bash_login"
rm -f $HOME/.bash_logout
echo "removed /home/.bash_logout"
rm -f $HOME/.profile
echo "removed /home/.profile"
mkdir -pv $HOME/.config/git
mv -v $HOME/.gitconfig $HOME/.config/git/config
echo "moved git config file in /home/.config"
mkdir -pv $HOME/.cache/zsh
touch $HOME/.cache/zsh/history
echo "created zsh history file"
mkdir $HOME/Pictures/screenshots
echo "created screenshots folder"
mkdir $HOME/Projects
echo "created projects folder"
mkdir $HOME/Downloads
echo "created downloads folder"
mkdir $HOME/Documents
echo "created documents folder"
mkdir $HOME/Music
echo "created music folder"
mkdir $HOME/Videos
echo "created videos folder"
mkdir $HOME/.local/bin-extras
touch $HOME/.local/bin-extras/machine-specific-hotkeys.conf
cp -f $HOME/.config/dotfilesgitconfig $HOME/.local/share/dotfiles/config

# version manager
curl https://mise.run | MISE_INSTALL_PATH=~/.local/bin-extras/mise sh

echo "pacman -Qe | cut -d' ' -f1 > installed" >> $HOME/.cache/zsh/history
echo "pacman -Syy --needed archlinux-keyring" >> $HOME/.cache/zsh/history
echo 'gh auth login' >> $HOME/.cache/zsh/history
echo "10000 pcmanfm-qt.desktop" > $HOME/.cache/rofi3.druncache

# make the qview configuration immutable
sudo chattr +i $HOME/.config/qView/qView.conf

# needed group
sudo gpasswd -a "$(whoami)" input

# yay
echo ""
echo -e "${GREEN}===${WHITE} INSTALLING YAY ${GREEN}===${NC}"
echo ""
sudo pacman -Syy --needed archlinux-keyring git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

rm -rf $HOME/yay
echo "removed /home/yay"

echo ""
echo -e "${BLUE}Finished.${NC}"
echo -e "${BLUE}Login to github using github cli (gh auth login).${NC}"
echo -e "${BLUE}Edit 'etc/pacman.conf'.${NC}"
echo -e "${BLUE}You can now reboot.${NC}"
