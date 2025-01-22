############################# Git #######################################################

gittyup() {
  git push --set-upstream origin $(git branch | grep "*" | awk '{print $2}')
}

gittypush() {
  git push
}

gitfetchdev() {
  CURRENT_GIT_BRANCH=$(git symbolic-ref --short HEAD)
  echo "Switching to dev to fetch and pull..."
  git checkout dev
  git fetch && git pull --rebase
  echo "Done! Switching back to $CURRENT_GIT_BRANCH"
  git checkout $CURRENT_GIT_BRANCH
}

gitnewbranch() {
  git checkout dev
  git fetch
  git pull --rebase
  git checkout -b "$1"
}

thursday() {
  readarray -t <<< $(cat /usr/share/dict/words | grep -ie "^th.*");size=${#MAPFILE[@]};idx=$(($RANDOM % $size)); echo "${MAPFILE[$idx]} Thursday" | sed 's/t/T/'
}

################################## Automated Common Tasks ########################

weekly-ftl() {
  GIT_BR="ftl-auto-$(date --iso-8601)"
  git checkout dev && git fetch && git pull --rebase && git checkout -b "ftl-auto-$GIT_BR"
  /home/margot/software/starfish/src/Starfish/_Build/PIL/Otter_Pup/tools/create_file_transfer.py &&
  git add . && git commit -m "[hotfix] Automatic FTL Update" && gittyup
}

listproc() {
  ps aux | grep -i $1
}

findx() {
  echo Searching for anything with \"$1\" in the name...
  echo

  find . -name "*$1*"
}

fix-ssh () {
    HOST=$1
    KNOWN_HOSTS="$HOME/.ssh/known_hosts"
    ssh-keygen -f "$KNOWN_HOSTS" -R "$HOST"
}

calc() {
  set -f
  echo "$@"
  echo "$@" | bc -l
  set +f

}

######################## System Stuff ##############################3
#

link-to() {
  echo "Linking $1 -> $2"
  ln -s $2 $1
}

# map ls to exa. use --classify for term output, but omit it otherwise (e.g. being piped)
ls() {
  if [[ -t 1 ]]; then
    exa --classify "$@"
  else
    exa "$@"
  fi
}

fix-audio() {
  for x in `amixer controls  | grep layback` ; do amixer cset "${x}" on ; done
  for x in `amixer controls  | grep layback` ; do amixer cset "${x}" 70% ; done
}

launch() {
  eval  "$@" > /dev/null 2>&1 & disown
}

up() {
  if [ -n "$1" ]; then
    for _ in $(seq 1 "$1"); do
      cd ..;
    done
  else
    cd ..
  fi
}

fcp() {
    local src="$1"
    local dest="$2"
    local dest_dir

    # Extract the directory path from the destination
    dest_dir=$(dirname "$dest")

    # Check if the destination directory exists
    if [ ! -d "$dest_dir" ]; then
        echo "The directory $dest_dir does not exist."
        
        # Prompt the user to create the directory
        read -p "Would you like to create it? (y/n) " choice
        
        case "$choice" in
            y|Y )
                mkdir -p "$dest_dir"
                echo "Directory created: $dest_dir"
                ;;
            n|N )
                echo "Directory not created. Aborting copy."
                return 1
                ;;
            * )
                echo "Invalid choice. Aborting."
                return 1
                ;;
        esac
    fi

    # Proceed with the copy
    cp "$src" "$dest" && echo "File copied to $dest"
}

######################## Display Stuff ##############################3

native_display_on() {
  xrandr --verbose --auto --output eDP-1 --mode 1920x1200
}

native_display_off(){
  xrandr --verbose --output eDP-1 --off
}

room-display-on() {
  set -e
  xrandr --verbose --output $1 --mode 3440x1440 --right-of eDP-1
  native_display_off
  feh --bg-fill ~/Pictures/wallpaper
  set +e
}

room-display-off() {
  set -e
  native_display_on
  xrandr --verbose --output $1 --off
  feh --bg-fill ~/Pictures/wallpaper
  set +e
}

office-display-on() {
  set -e
  xrandr --verbose --output $DP_LEFT_FRONT --mode 2560x1440 --left-of eDP-1
  xrandr --verbose --output $DP_LEFT_FRONT --rotate right
  xrandr --verbose --output $DP_LEFT_BACK --mode 3440x1440 --right-of eDP-1
  native_display_off
  feh --bg-fill ~/Pictures/wallpaper --bg-fill ~/Pictures/wallpaper
  set +e
}

office-display-off() {
  set -e
  native_display_on
  xrandr --verbose --output $DP_LEFT_BACK --off
  xrandr --verbose --output $DP_LEFT_FRONT --off
  feh --bg-fill ~/Pictures/wallpaper
  set +e
}

###################### MAX Stuff ###########################################

run-max-gds() {
  set -x
  EXEC_FILE=$(find /home/margot/software/starfish/src/Starfish/_Build/PIL/Otter_Pup/flat_sat_test_procedures -type f -name $1*_gds.py)
  echo "Found GDS file: $EXEC_FILE"
  LOG_DIR=$(date +%s)
  echo "Logs will be sent to MAX_GDS_DATA/logs/$LOG_DIR"
  mkdir MAX_GDS_DATA/logs/$LOG_DIR
  python3 MAX_GDS/scripts/run_master_ui.py --execfile $EXEC_FILE --logfile_dir MAX_GDS_Data/logs/$LOG_DIR
  set +x
}
