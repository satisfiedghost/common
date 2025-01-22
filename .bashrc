# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

set -o vi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# remotes generallly don't like when terminfo has alacritty for $TERM
if [ "$TERM" = "alacritty" ]; then
    export TERM=xterm-256color
fi

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;12m\]\u\[\033[38;5;8m\]@\[\033[38;5;251m\]uscss-nostromo\[\033[38;5;8m\]:\[\033[38;5;81m\]\w\[\033[38;5;230m\] \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@uscss-nostromo:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export EXA_COLORS=reset:$LS_COLORS
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



## Starfish machine_config stuff
_MACHINE_CFG_DIR=/home/margot/software/starfish/tools/machine_config
# common
source $_MACHINE_CFG_DIR/shortcuts/shortcuts_common_cli.sh
source $_MACHINE_CFG_DIR/shortcuts/shortcuts_common_sf.sh
# os-specific
if [[ "$OSTYPE" == "linux"* ]]; then source $_MACHINE_CFG_DIR/shortcuts/shortcuts_common_linux.sh; fi
if [[ "$OSTYPE" == "darwin"* ]]; then source $_MACHINE_CFG_DIR/shortcuts/shortcuts_common_mac.sh; fi
# user (margot)
USER_SHORTCUTS=$_MACHINE_CFG_DIR/shortcuts/users/shortcuts_margot.sh
if [ -e $USER_SHORTCUTS ] ; then source $USER_SHORTCUTS; fi

source ~/.bash_aliases

export PATH=$PATH:~/bin
export PATH=$PATH:/opt/nvim/
export PATH=$PATH:/home/margot/.cargo/bin

source /usr/share/doc/fzf/examples/key-bindings.bash

# Use a unique history file for tmux sessions
if [ -n "$TMUX" ]; then
    HISTFILE=~/.bash_history_tmux
    cat ~/.bash_history >> ~/.bash_history_tmux
fi

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=50000
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

shopt -s histappend
PROMPT_COMMAND="history -a; history -r"

# Cycle through tab completions
bind 'TAB:menu-complete'

# Shift-tab will cycle backwards
bind '"\e[Z": menu-complete-backward'

# Display a list of matching files
bind "set show-all-if-ambiguous on"

# Perform partial completion on the first Tab press, and
# start cycling results on the second press.
bind "set menu-complete-display-prefix on"

# Define Vars
export SF_SRC="$HOME/software/starfish/src"

#neofetch --ascii /home/margot/.logo --color_blocks off | lolcat
#if ! { [ -z "$TMUX" ]; } then
#  neofetch
#else
#COWS=(/home/margot/.cows/share/cowsay-files/cows/*)
#RAND_COW=$(($RANDOM % $( ls /home/margot/.cows/share/cowsay-files/cows/*.cow | wc -l )))
#fortune | cowsay -f ${COWS[$RAND_COW]} -W 30
##neofetch --ascii $(fortune | cowsay -f /home/margot/.cows/share/cowsay-files/cows/aperture-blank.cow -W 30) | lolcat
##  #neofetch --ascii /home/margot/.cows/share/cowsay-files/cows/aperture-blank.cow
##  neofetch --ascii /home/mar| lolcat
#fi

echo
cat $HOME/.config/margot/banner.txt
echo -e "\e[4;38;2;51;255;0m"
echo SPECIAL ORDER 937
echo -ne "\e[24m"
echo PRIORITY ONE
echo ENSURE RETURN OF ORGANISM FOR ANALYSIS.
echo ALL OTHER CONSIDERATIONS SECONDARY.
echo CREW EXPENDABLE.
echo -ne "\e[0m"

export FJ_DIR="/home/margot/software/starfish/src/Starfish/_Build/PIL/Otter_Pup/flat_sat_test_procedures"

argus-sdk() {
   #source /usr/local/oecore-x86_64/environment-setup-aarch64-oe-linux
   source /usr/local/oecore-x86_64/environment-setup-armv7a-neon-oemllib32-linux-gnueabi
}

source $HOME/.bash_functions
source $HOME/.bash_env

eval $(thefuck --alias)
eval $(thefuck --alias shit)
eval $(thefuck --alias oops)
eval $(thefuck --alias dammit)

shopt -s direxpand

# I like having a newline between the banner and my prompt
echo


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
