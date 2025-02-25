local M = {}

M.setup = function()
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--branch=stable",
            lazyrepo,
            lazypath,
        })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)

    -- Make sure to setup `mapleader` and `maplocalleader` before
    -- loading lazy.nvim so that mappings are correct.
    -- This is also a good place to setup other settings (vim.opt)
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"

    -- Setup lazy.nvim
    require("lazy").setup({
        spec = {
            -- import your plugins
            { import = "mwyerman.plugins" },
            {
                "vhyrro/luarocks.nvim",
                priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
                opts = {
                    rocks = { "lsqlite3complete" }, -- specifies a list of rocks to install
                    -- luarocks_build_args = { "--with-lua=/my/path" }, -- extra options to pass to luarocks's configuration script
                },
            },
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        -- install = { colorscheme = { "habamax" } },
        -- automatically check for plugin updates
        checker = { enabled = true, notify = false },
        change_detection = { enabled = true, notify = false },
    })
end

return M
