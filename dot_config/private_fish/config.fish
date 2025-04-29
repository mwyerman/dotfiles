if status is-interactive
    # Commands to run in interactive sessions can go here
    set shell_theme tokyonight_night
    source ~/.config/fish/themes/$shell_theme.fish
end

set PATH $PATH ~/.local/bin /opt/nvim-linux-x86_64/bin
