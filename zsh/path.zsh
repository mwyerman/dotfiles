PATH="/home/mwyerman/.local/bin:$PATH"
PATH="/home/mwyerman/.cargo/bin:$PATH"
PATH="/home/mwyerman/bin:$PATH"

# if ~/.zfunc exists, add it to fpath
if [ -d ~/.zfunc ]; then
  fpath=(~/.zfunc $fpath)
fi
