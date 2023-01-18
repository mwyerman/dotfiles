#!/bin/bash
BASEDIR=$(pwd)

YELLOW='\033[1;33m'
NC='\033[0m' # No Color

symlink() {
  case $1 in
    # dirs to ~/.config
    nvim|kitty)
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
  esac
}

for file in $@; do
  symlink $file
done
