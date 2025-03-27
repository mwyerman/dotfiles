return {
    --- nvim development helper
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    --- formatting
    {
        "stevearc/conform.nvim",
        keys = {
            {
                "==",
                function(bufnr)
                    require("conform").format({ bufnr = bufnr })
                end,
                desc = "format",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                json = { "prettier" },
                rust = { "rustfmt", lsp_format = "fallback" },
                python = { "ruff_format" },
                c = { "clang-format" },
                -- ["_"] = { "trim_newlines", "trim_whitespace" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        },
    },
}
