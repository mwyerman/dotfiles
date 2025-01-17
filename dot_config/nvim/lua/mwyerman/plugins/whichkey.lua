return {
    "folke/which-key.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show()
            end,
            desc = "show keybindings",
        },
    },
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>t", group = "terminal" },
            { "<leader>l", group = "lsp" },
            { "<leader>f", group = "find" },
        })
    end,
}
