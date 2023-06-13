ZDOTDIR=${HOME}/.zsh
source $ZDOTDIR/init.zsh
if [ -e $ZDOTDIR/secrets.zsh ]; then
  source $ZDOTDIR/secrets.zsh
fi
source $ZDOTDIR/git.zsh
source $ZDOTDIR/path.zsh
source $ZDOTDIR/misc.zsh
