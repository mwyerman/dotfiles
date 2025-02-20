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

    --- move lines up and down when selected, with indent awareness
    bindv("J", ":m '>+1<cr>gv=gv")
    bindv("K", ":m '>-2<cr>gv=gv")

    --- don't replace yank buffer in visual mode
    bindv("p", [["_dP]])

    --- indent and unindent lines
    bindv("H", "<gv")
    bindv("L", ">gv")

    --- easy split navigation
    bindn("<C-h>", "<C-w>h")
    bindn("<C-j>", "<C-w>j")
    bindn("<C-k>", "<C-w>k")
    bindn("<C-l>", "<C-w>l")

    --- J keeps cursor in one place
    bindn("J", "mzJ`z")

    --- center screen on ctrl-u/ctrl-d
    bindn("<C-d>", "<C-d>zz")
    bindn("<C-u>", "<C-u>zz")

    --- center screen (and unfold) on n/N
    bindn("n", "nzzzv")
    bindn("N", "Nzzzv")

    bindn("Q", "<nop>")
end

return M
