# git
abbr --add gs 'git status -s'
abbr --add gS 'git status'
abbr --add ga 'git add'
abbr --add gA 'git add .'
abbr --add gcm 'git commit -m'
abbr --add gca 'git commit --amend'
abbr --add gcA 'git commit --amend --no-edit'
abbr --add gd 'git diff'
abbr --add gp 'git push'
abbr --add gpl 'git pull'
abbr --add gf 'git fetch'
abbr --add gl 'git lg'

# alternatives
if command -q eza
    abbr l eza 
    abbr ls eza -l
    abbr ll eza -la
    abbr la eza -la
else
    abbr l ls 
    abbr ls ls -l
    abbr ll ls -la
    abbr la ls -la
end
