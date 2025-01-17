local M = {}

M.setup = function()
    -- if vim.loop.os_uname().sysname == "Windows_NT" then
    --     vim.o.shell = "pwsh.exe"
    -- end

    --- window nav in terminal mode
    vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>")
    vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>")
    vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>")
    vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>")
    vim.keymap.set("t", "<M-\\>", "<C-\\><C-n>")
end

M.new_term = function()
    vim.cmd.terminal()
    vim.cmd.startinsert()
end

M.new_term_vsplit = function()
    vim.cmd.vsplit()
    M.new_term()
end

M.new_term_hsplit = function()
    vim.cmd.split()
    M.new_term()
end

return M
