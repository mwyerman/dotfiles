# if eza installed, use it
if [ -x "$(command -v eza)" ]; then
  alias ls="eza"
  alias la="eza -lA"
  alias ll="eza -l"
else
  alias la="ls -lAFh"
  alias ll="ls -lh"
fi

# grep with color
alias grep="grep --color"

# cd aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
# reload zshrc
alias r="source ~/.zshrc"

# history
alias h="history"
alias hs="history | grep"

# search aliases for command
alias sa="alias | grep"

export EDITOR="nvim"

# firefox bin
alias firefox="firefox-bin"
alias python="python3"

# fix issues with tmpdir in wsl
export TMPDIR="/tmp"
export TMUX_TMPDIR="/tmp"
