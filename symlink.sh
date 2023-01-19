#!/bin/bash
BASEDIR=$(pwd)

YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# if -f or --force is passed, set FORCE to true
if [ "$1" = "-f" ] || [ "$1" = "--force" ]; then
  FORCE=true
  shift
fi

symlink_with_destination() {
  SOURCE=$1
  DESTINATION=$2
  SUDO=$3

  if [ "$SUDO" = "true" ]; then
    SUDO="sudo"
  else
    SUDO=""
  fi

  # if destination folder or file does not exist, create symlink
  # if FORCE is true and file or folder exists, move it to .old and create symlink
  # if FORCE is true and symlink exists, remove it and create symlink
  if [ "$FORCE" = true ]; then
    if [ -L "$DESTINATION" ]; then
      $SUDO rm "$DESTINATION"
      echo -e "${RED}(FORCED)${YELLOW} Removed symlink: $DESTINATION${NC}"
    fi
    if [ -e "$DESTINATION" ]; then
      $SUDO mv "$DESTINATION" "$DESTINATION.old"
      echo -e "${RED}(FORCED)${YELLOW} Moved $DESTINATION to $DESTINATION.old${NC}"
    fi
  fi

  if [ -L "$DESTINATION" ]; then
    echo -e "${YELLOW}Symlink already exists: $DESTINATION ${NC}"
  elif [ -e "$DESTINATION" ]; then
    echo -e "${YELLOW}File or folder already exists: $DESTINATION${NC}"
  else
    $SUDO ln -s "$SOURCE" "$DESTINATION"
    echo -e "${NC}Created symlink: $DESTINATION${NC}"
  fi
}

symlink() {
  case $1 in
    # dirs to ~/.config
    nvim|kitty|ranger|neofetch)
      symlink_with_destination "$BASEDIR/$1" "$HOME/.config/$1"
      ;;
    # files to ~ with dot
    tmux.conf)
      symlink_with_destination "$BASEDIR/$1" "$HOME/.$1"
      ;;
    # dwm-flexipatch/ to /etc/portage/savedconfig/x11-wm/dwm-flexipatch-9999
    dwm-flexipatch)
      symlink_with_destination "$BASEDIR/$1" "/etc/portage/savedconfig/x11-wm/dwm-flexipatch-9999" true
      ;;
    # zshrc to ~/.zshrc and zsh/ to ~/.zsh (either will create both symlinks)
    zshrc|zsh)
      symlink_with_destination "$BASEDIR/zshrc" "$HOME/.zshrc"
      symlink_with_destination "$BASEDIR/zsh" "$HOME/.zsh"
      ;;
  esac
}

# if arg is all, symlink all nonhidden files in basedir except this script and README
if [ "$1" == "all" ]; then
  for file in $(ls -A $BASEDIR | grep -vE "readme|symlink.sh"); do
    symlink $file
  done
else
  for file in $@; do
    symlink $file
  done
fi

