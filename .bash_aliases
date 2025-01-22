# Wireguard
alias wg-full-up='sudo wg-quick up SF_VPN_Full_1'
alias wg-split-up='sudo wg-quick up SF_VPN_Split_1'
alias wg-full-down='sudo wg-quick down SF_VPN_Full_1'
alias wg-split-down='sudo wg-quick down SF_VPN_Split_1'
alias wg-show='sudo wg show'

# Display Stuff
alias dp-2-on='xrandr --verbose --auto --output DP-2 --mode 1680x1050 --left-of eDP-1'
alias dp-3-on='xrandr --verbose --auto --output DP-3 --mode 1680x1050 --left-of eDP-1'
alias dp-2-off='xrandr --output DP-2 --off'
alias dp-3-off='xrandr --output DP-3 --off'

# Starfish Repo
alias sf-clean='python3.11 conanfile.py --generator Ninja --clean --vizInterface False'
alias sf-env='source ~/.config/virtualenvs/sf311/bin/activate'

# System Navigation
alias xc-copy="tr -d '\n' | xclip"
alias xc-paste="xclip -o"
alias sys-copy="tr -d '\n' | xclip -selection clipboard"
alias sys-paste="xclip -o -selection clipboard"

# FTL
alias restore-ftl='(goto-pil && git restore *.txt && git restore ./tools/*.txt && git restore ./tools/ftl_meta.json)'

# Git
alias git-pull='git pull'
alias git-fetch='git fetch'
alias git-rebase='git pull --rebase'
alias git-makebranch='git checkout -b'
alias git-fixup='git rebase -i HEAD~2'

# GDS
alias max-env="source ~/.config/virtualenvs/maxgds/bin/activate"
alias max-ui="python3 /home/margot/storage/MAX_GDS/scripts/run_master_ui.py"

# Misc. Convenience
alias bashrc="vim ~/.bashrc && source ~/.bashrc"
alias bashfunctions="vim ~/.bash_functions && source ~/.bash_functions"
alias bash_aliases="vim ~/.bash_aliases && source ~/.bash_aliases"
alias vim="nvim"
alias en="chmod +x"

alias ssh-argus="echo "uPv92ZxteY" | sys-copy && ssh -t root@192.168.3.12 'bash -l'" # copy argus PW to system clipboard & ssh to it
alias r="fc -s"
alias recent="fc -l -10"
alias cgrep="grep --color=always"

alias rainbowfall="hexdump -C /dev/random | pv -q -L 1200 | lolcat"

alias make-tar="tar -cvzf"

# System Sounds
alias change-output="pavucontrol"

# Program Shortcuts
alias ti-studio="/home/margot/ti/ccs1260/ccs/eclipse/ccstudio"

# System Management
alias kill-pattern="pkill -f"
alias remove-dirs='find . -type d ! -name ".*" | xargs rm -r'

# PIL
alias pilutil-opup="python3.11 $HOME/software/starfish/src/Starfish/utilities/fsw/pil_utilities.py --yaml $HOME/software/starfish/src/Starfish/utilities/fsw/pil_util_opup.yaml"
alias pilutil-em="python3 $HOME/software/starfish/src/Starfish/utilities/fsw/pil_utilities.py --yaml $HOME/software/starfish/src/Starfish/utilities/fsw/pil_util_opup.yaml"

alias cycle-nx-1='ssh narwhal@192.168.3.180 "source ~/Software/basilisk_derived/src/Starfish/_Build/python_env/source_virtualenv; echo -ne \"1\ncycle\n\" | /home/narwhal/.local/bin/pil-power"'
alias cycle-nx-2='ssh narwhal@192.168.3.180 "source ~/Software/basilisk_derived/src/Starfish/_Build/python_env/source_virtualenv; echo -ne \"2\ncycle\n\" | /home/narwhal/.local/bin/pil-power"'
