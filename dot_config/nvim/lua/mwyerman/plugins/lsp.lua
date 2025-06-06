local function create_lsp_keymaps(event)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover", buffer = event.buf })
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "signature help", buffer = event.buf })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "diagnostics", buffer = event.buf })
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "code actions", buffer = event.buf })
    vim.keymap.set("v", "ga", vim.lsp.buf.code_action, { desc = "code actions", buffer = event.buf })
    vim.keymap.set("n", "gR", vim.lsp.buf.rename, { desc = "rename", buffer = event.buf })
    vim.keymap.set("n", "<leader>lR", "<cmd>LspRestart<cr>", { desc = "restart lsp", buffer = event.buf })
    vim.keymap.set("n", "<leader>lI", "<cmd>LspInfo<cr>", { desc = "lsp info", buffer = event.buf })
    vim.keymap.set("n", "<leader>lL", "<cmd>LspLog<cr>", { desc = "lsp log", buffer = event.buf })
end

return {
    --- LSP
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("clangd")
            vim.lsp.enable("rust_analyzer")
            vim.lsp.enable("pyright")
            vim.lsp.enable("jsonls")
            vim.lsp.enable("svelte")
            vim.lsp.enable("ts_ls")

            local lspconfig = require("lspconfig")
            lspconfig.svelte.setup({
                handlers = {
                    ["textDocument/didSave"] = function(_, result, ctx, config)
                        local saved_file = vim.uri_to_fname(result.textDocument.uri)
                        if saved_file:match("%.ts$") then
                            vim.lsp.stop_client(ctx.client_id)
                            vim.def_fn(function()
                                lspconfig.svelte.launch()
                            end, 50)
                        end
                    end,
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP Keymaps",
                callback = function(args)
                    create_lsp_keymaps(args)

                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if
                        client ~= nil
                        and client.server_capabilities.inlayHintProvider
                        and not vim.lsp.inlay_hint.is_enabled()
                    then
                        vim.lsp.inlay_hint.enable(true)
                    end
                end,
            })
        end,
    },
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
        config = function()
            require("conform").setup({
                log_level = vim.log.levels.DEBUG,
                formatters_by_ft = {
                    lua = { "stylua" },
                    json = { "prettier" },
                    javascript = { "prettier" },
                    markdown = { "prettier_markdown" },
                    typescript = { "prettier" },
                    svelte = { "prettier" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                    python = { "ruff_format" },
                    c = { "clang-format" },
                    -- ["_"] = { "trim_newlines", "trim_whitespace" },
                },
                default_format_opts = {
                    lsp_format = "fallback",
                },
            })

            local md_formatter = vim.deepcopy(require("conform.formatters.prettier"))
            require("conform.util").add_formatter_args(md_formatter, {
                "--prose-wrap",
                "always",
                "--print-width",
                "80",
            }, { append = false })
            ---@cast md_formatter conform.FormatterConfigOverride
            require("conform").formatters.prettier_markdown = md_formatter
        end,
    },
}
