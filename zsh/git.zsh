alias g="git"

# delta pager should always be side-by-side
alias delta="delta -s"

# status and diff
alias gs="git status"
alias gd="git diff"
alias gdd="git diff | delta"

alias gdc="git diff --cached"

alias gds="git diff --staged"
alias gdds="git diff --staged | delta"

# branches
alias gb="git branch"
alias gbl="git branch -a"
alias gbd="git branch -d"
alias gbD="git branch -D"

function gbp() {
  if git fetch --prune && git branch -vv | grep ': gone]' >/dev/null; then
    git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d
  else
    echo "No local branches to delete."
  fi
}

function gbP() {
  if git fetch --prune && git branch -vv | grep ': gone]' >/dev/null; then
    git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
  else
    echo "No local branches to delete."
  fi
}

# commits
alias ga="git add"
alias g.="git add ."
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"

alias gco="git checkout"

# remotes
alias gp="git push"
alias gpl="git pull"
alias gpf="git push --force"

# fetch
alias gf="git fetch"
alias gfa="git fetch --all"
alias gfp="git fetch --prune --all"

# log
function gl() {
  if [ -z "$1" ]; then
    NUMOPT="-n 10"
  elif [ "$1" = "a" ] || [ "$1" = "all" ]; then
    NUMOPT=""
  else
    NUMOPT="-n $1"
  fi

  git log --oneline --decorate --color --pretty=format:'%Cred%h%Creset - %Cgreen%ah%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an|%ae>%Creset' $NUMOPT
}

function gll() {
  if [ -z "$1" ]; then
    NUMOPT="-n 5"
  elif [ "$1" = "a" ] || [ "$1" = "all" ]; then
    NUMOPT=""
  else
    NUMOPT="-n $1"
  fi
  git log $NUMOPT
}

function gg() {
  if [ -z "$1" ]; then
    NUMOPT="-n 10"
  elif [ "$1" = "a" ] || [ "$1" = "all" ]; then
    NUMOPT=""
  else
    NUMOPT="-n $1"
  fi
  # git log --oneline --decorate --graph --all --color --pretty=format:'%Cred%h%Creset - %Cgreen%ah%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an|%ae>%Creset' $NUMOPT
  git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)' $NUMOPT
}


# config

# if variables not set, tell user to create secrets.zsh file
if [ -z "$GIT_NAME" ] || [ -z "$GIT_WORK_EMAIL" ] || [ -z "$GIT_PERSONAL_EMAIL" ]; then
  echo "Please create a ~/.zsh/secrets.zsh file with the following variables:"
  echo "export GIT_NAME=\"<your name>\""
  echo "export GIT_WORK_EMAIL=\"<your work email>\""
  echo "export GIT_PERSONAL_EMAIL=\"<your personal email>\""
  return
fi
alias gcu="git config user.name '$GIT_NAME'"
alias gce="git config user.email"
alias gcew="git config user.email $GIT_WORK_EMAIL"
alias gcep="git config user.email $GIT_PERSONAL_EMAIL"
