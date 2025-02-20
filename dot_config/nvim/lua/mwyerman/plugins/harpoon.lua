return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>ha", function()
                harpoon:list():add()
            end, { desc = "add to harpoon" })
            vim.keymap.set("n", "<leader>H", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "harpoon" })

            for i = 1, 9 do
                -- vim.keymap.set("n", "<C-" .. i .. ">", function()
                --     harpoon:list():select(i)
                -- end)
                vim.keymap.set("n", "'" .. i, function()
                    harpoon:list():select(i)
                end, {desc = "Harpoon to ".. i})
            end
        end,
    }
}
