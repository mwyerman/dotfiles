#!/bin/bash
BASEDIR=$(pwd)

YELLOW='\033[1;33m'
NC='\033[0m' # No Color

symlink() {
  case $1 in
    # dirs to ~/.config
    nvim|kitty|ranger|neofetch)
      if [ ! -d ~/.config/$1 ]; then
        echo "Symlinking $BASEDIR/$1 to ~/.config/$1" ;
        ln -s $BASEDIR/$1 ~/.config/$1 ;
      else
        echo -e "${YELLOW}~/.config/$1 already exists. Skipping...${NC}" ;
      fi
      ;;
    # files to ~ with dot
    tmux.conf)
      if [ -e ~/.$1 ]; then
        echo -e "${YELLOW}~/.$1 already exists. Skipping...${NC}" ;
      else
        echo "Symlinking $1 to ~/.$1" ;
        ln -s $BASEDIR/$1 ~/.$1 ;
      fi
      ;;
    # dwm-flexipatch/ to /etc/portage/savedconfig/x11-wm/dwm-flexipatch-9999
    dwm-flexipatch)
      if [ ! -d /etc/portage/savedconfig/x11-wm/dwm-flexipatch-9999 ]; then
        echo "Symlinking $BASEDIR/$1 to /etc/portage/savedconfig/x11-wm/dwm-flexipatch-9999" ;
        sudo ln -s $BASEDIR/$1 /etc/portage/savedconfig/x11-wm/dwm-flexipatch-9999 ;
      else
        echo -e "${YELLOW}/etc/portage/savedconfig/x11-wm/dwm-flexipatch-9999 already exists. Skipping...${NC}" ;
      fi
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

