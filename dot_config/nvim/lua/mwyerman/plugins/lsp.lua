local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return true
        end,
        bufnr = bufnr,
    })
end

local function create_lsp_keymaps(event)
    -- stylua: ignore start
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover", buffer = event.buf })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "definition", buffer = event.buf })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "declaration", buffer = event.buf })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "implementation", buffer = event.buf })
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { desc = "type definition", buffer = event.buf })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "references", buffer = event.buf })
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "signature help", buffer = event.buf })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "diagnostics", buffer = event.buf })
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "code actions", buffer = event.buf })
    vim.keymap.set("v", "ga", vim.lsp.buf.code_action, { desc = "code actions", buffer = event.buf })
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "rename", buffer = event.buf })
    vim.keymap.set("n", "<leader>lf", lsp_formatting, { desc = "format", buffer = event.buf })
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "code actions", buffer = event.buf })
    vim.keymap.set("n", "<leader>lR", "<cmd>LspRestart<cr>", { desc = "restart lsp", buffer = event.buf })
    -- stylua: ignore end
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
    },

    config = function()
        --- attach keymaps
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP Keymaps",
            callback = function(args)
                create_lsp_keymaps(args)

                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if
                    client.server_capabilities.inlayHintProvider
                    and not vim.lsp.inlay_hint.is_enabled()
                then
                    vim.lsp.inlay_hint.enable(true)
                end
            end,
        })

        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-tool-installer").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "pyright",
                "clangd",
                "cssls",
                "eslint",
                "jsonls",
                "ts_ls",
                "taplo",
                "html",
                "yamlls",
                "cmake",
                "dockerls",
                "bashls",
                "powershell_es",
                "stylua",
                "prettier",
                "clang-format",
            },
        })
        require("mason-lspconfig").setup({
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                rust_analyzer = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.rust_analyzer.setup({
                        settings = {
                            ["rust-analyzer"] = {
                                cargo = {
                                    features = "all",
                                },
                                inlayHints = {
                                    enable = true,
                                },
                            },
                        },
                    })
                end,
                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(
                            ".git",
                            "build.zig",
                            "zls.json"
                        ),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                end,
                lua_ls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = {
                                        "bit",
                                        "vim",
                                        "it",
                                        "describe",
                                        "before_each",
                                        "after_each",
                                    },
                                },
                            },
                        },
                    })
                end,
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        for _, method in ipairs({
            "textDocument/diagnostic",
            "workspace/diagnostic",
        }) do
            local default_diagnostic_handler = vim.lsp.handlers[method]
            vim.lsp.handlers[method] = function(err, result, context, config)
                if err ~= nil and err.code == -32802 then
                    return
                end
                return default_diagnostic_handler(err, result, context, config)
            end
        end

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
                ["<cr>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "path" },
            }, {
                { name = "buffer" },
            }),
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
