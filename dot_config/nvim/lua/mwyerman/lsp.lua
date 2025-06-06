local M = {}

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

M.setup_keymap_autocmd = function()
    --- attach keymaps
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
end

M.enable_language_servers = function()
    vim.lsp.enable({
        "lua_ls",
        "clangd",
        "rust_analyzer",
        "pyright",
        "jsonls",
        "svelte",
    })
end

M.setup = function()
    -- M.enable_language_servers()
    -- M.setup_keymap_autocmd()
end

return M
