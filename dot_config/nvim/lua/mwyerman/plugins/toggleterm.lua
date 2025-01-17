return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            size = function(term)
                if term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
                return 20
            end,
            open_mapping = "<C-\\>",
            direction = "vertical",
            shell = function()
                if vim.loop.os_uname().sysname == "Windows_NT" then
                    return "pwsh.exe"
                else
                    return vim.o.shell
                end
            end
        })
    end
}
