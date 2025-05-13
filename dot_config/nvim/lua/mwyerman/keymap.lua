local M = {}

local term = require("mwyerman.terminal")

M.setup = function()
    -- keymaps
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    local function bindn(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { ["desc"] = desc })
    end

    local function bindv(lhs, rhs)
        vim.keymap.set("v", lhs, rhs)
    end

    --- tabs
    bindn("<C-w>N", "<cmd>tabnew<cr>", "Create new empty tag")
    bindn("<C-w>D", "<cmd>tabclose<cr>", "Close the current tag")
    bindn("<leader>tN", "<cmd>tabnew<cr>", "Create new empty tag")
    bindn("<leader>tD", "<cmd>tabclose<cr>", "Close the current tag")
    bindn("<leader>tt", "<cmd>tabn<cr>", "Next tab")
    bindn("<leader>tT", "<cmd>tabp<cr>", "Prev tab")

    --- window controls
    bindn("<leader>wl", "<cmd>vsplit<cr>", "split right")
    bindn("<leader>wj", "<cmd>split<cr>", "split down")


    --- don't replace yank buffer in visual mode
    bindv("p", [["_dP]])

    --- indent and unindent lines
    bindv("H", "<gv")
    bindv("L", ">gv")

    --- easy split navigation
    bindn("<C-h>", "<C-w>h", "Go to the left window")
    bindn("<C-j>", "<C-w>j", "Go to the down window")
    bindn("<C-k>", "<C-w>k", "Go to the up window")
    bindn("<C-l>", "<C-w>l", "Go to the right window")

    --- J keeps cursor in one place
    bindn("J", "mzJ`z")

    --- center screen on ctrl-u/ctrl-d
    bindn("<C-d>", "<C-d>zz", "Scroll down")
    bindn("<C-u>", "<C-u>zz", "Scroll up")

    --- center screen (and unfold) on n/N
    bindn("n", "nzzzv")
    bindn("N", "Nzzzv")

    bindn("Q", "<nop>")
end

return M
