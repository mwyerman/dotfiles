alias g="git"

# status and diff
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gds="git diff --staged"

# branches
alias gb="git branch"
alias gbl="git branch -a"

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

# log
alias gl="git log --oneline --decorate --color --pretty=format:'%Cred%h%Creset - %Cgreen%ah%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an|%ae>%Creset'"
alias gll="git log"
alias gg="git log --oneline --decorate --graph --all --color --pretty=format:'%Cred%h%Creset - %Cgreen%ah%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an|%ae>%Creset'"

# config
alias gcu="git config user.name '$GIT_NAME'"
alias gce="git config user.email"
alias gcew="git config user.email $GIT_WORK_EMAIL"
alias gcep="git config user.email $GIT_PERSONAL_EMAIL"
