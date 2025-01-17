---@type LazySpec
return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>e",
            "<cmd>Yazi<cr>",
            desc = "open file browser",
        }
    },
    opts = {
        open_for_directories = true,
        keymaps = {
            show_help = '<C-/>',
        }
    }

}
