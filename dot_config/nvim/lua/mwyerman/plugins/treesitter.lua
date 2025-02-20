return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local install = require("nvim-treesitter.install")
            install.prefer_git = false

            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "rust",
                    "python",
                    "javascript",
                    "typescript",
                    "bash",
                    "yaml",
                    "toml",
                    "json",
                    "html",
                    "markdown",
                    "markdown_inline",
                    "styled",
                    "css",
                    "regex",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    additiona_vim_regex_highlighting = false,
                },
            })
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
                languages = {
                    c = "// %s",
                    cpp = "// %s",
                },
            })

            local get_option = vim.filetype.get_option
            vim.filetype.get_option = function(filetype, option)
                return option == "commentstring"
                    and require("ts_context_commentstring.internal").calculate_commentstring()
                    or get_option(filetype, option)
            end
        end,
    },
}
