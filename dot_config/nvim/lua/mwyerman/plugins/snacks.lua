---@type LazySpec
return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            quickfile = {},
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
            { "<leader>ff", function() Snacks.picker.smart() end,    desc = "Smart Find Files" },
            { "<leader>fg", function() Snacks.picker.grep() end,     desc = "Grep" },
            { "<leader>fb", function() Snacks.picker.buffers() end,  desc = "Buffers" },
            { "<leader>fh", function() Snacks.picker.help() end,     desc = "Help" },
            { "<leader>e",  function() Snacks.explorer() end,        desc = "File Tree" },
            { "<C-\\>",     function() Snacks.terminal.toggle() end, desc = "Terminal",        mode = { "n", "t" } },
        },
    }
}
