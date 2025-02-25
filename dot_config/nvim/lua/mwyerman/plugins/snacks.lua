---@type LazySpec
return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            quickfile = {},
            notifier = {},
            picker = {},
            explorer = {
                replace_netrw = true,
            },
            terminal = {
                enabled = true,
                win = {
                    style = "terminal",
                    position = "right",
                }
            },
        },
        keys = {
            { "<leader>ff", function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
            { "<leader>fg", function() Snacks.picker.grep() end,                  desc = "Grep" },
            { "<leader>fb", function() Snacks.picker.buffers() end,               desc = "Buffers" },
            { "<leader>fh", function() Snacks.picker.help() end,                  desc = "Help" },
            { "<leader>e",  function() Snacks.explorer() end,                     desc = "File Tree" },
            { "<C-\\>",     function() Snacks.terminal.toggle() end,              desc = "Terminal",              mode = { "n", "t" } },
            { "<leader>M",  function() Snacks.notifier.show_history() end,        desc = "Message history" },
            --- LSP Pickers
            { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
            { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
            { "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                  desc = "References" },
            { "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
            { "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
            { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
            { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        },
    }
}
