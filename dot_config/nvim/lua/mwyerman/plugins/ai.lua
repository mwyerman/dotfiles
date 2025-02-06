return {
    {
        "supermaven-inc/supermaven-nvim",
        keys = {
            {
                "<leader>a",
                ":SupermavenToggle<cr>",
                desc = "Toggle AI",
            },
        },
        config = function ()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<S-Tab>",
                }
            })
            require("supermaven-nvim.api").toggle()
        end
    },
}
