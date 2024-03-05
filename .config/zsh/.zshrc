# Profiling
#zmodload zsh/zprof   

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Options
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt HIST_IGNORE_SPACE

autoload -U colors && colors
autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)  # include hidden files.

# Aliases
alias ls="ls --color=auto"
alias ll="ls --group-directories-first -la --ignore=.."
alias du="du -shc"
alias vim="nvim"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias bat="~/.local/bin/battery.sh"
alias start="startx"

# Variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export TERMINAL="/usr/bin/alacritty"
export BROWSER="/usr/bin/firefox"

export PATH="$PATH:/home/edisan/.dotnet/tools"

export QT_QPA_PLATFORMTHEME=qt5ct
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export XINITRC="$XDG_CONFIG_HOME/xinitrc"

# Plugins
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# NVM
# Slows zsh start-up time significantly
# Uncomment only if you need to install other node versions
#export NVM_DIR=~/.local/share/nvm
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Use node without nvm
source $HOME/.local/bin/node.sh

#zprof
