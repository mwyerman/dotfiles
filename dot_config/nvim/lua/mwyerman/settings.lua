local M = {}

M.setup = function()
    --- general/visual
    vim.opt.number = true -- enable line numbers
    vim.opt.relativenumber = true -- enable relative line numbers
    vim.opt.cursorline = true -- highlight the current cursor line
    vim.opt.splitright = true -- split right on vsplit
    vim.opt.splitbelow = true -- split below on hsplit
    vim.opt.foldlevelstart = 99 -- no autofolds
    vim.opt.scrolloff = 5 -- keep cursor 10 lines away from edge of screen
    vim.opt.sidescrolloff = 10 -- keep cursor 10 cols away from edge of screen
    vim.opt.cmdheight = 0 -- hide command line when not in use
    vim.opt.wrap = false -- no word wrap

    --- whitespace chars
    vim.opt.list = true -- enable listchars
    vim.opt.listchars = { -- chars to show
        tab = "-->",
        multispace = " ",
        trail = ".",
        extends = ">",
        precedes = "<",
    }

    --- persistant history/recovery
    -- disabling swapfiles because they tend to cause me more
    -- problems than they help
    vim.opt.swapfile = false -- don't use swap files
    vim.opt.scrollback = 5000 -- :h term history

    --- tabs
    vim.opt.autoindent = true -- indent automatically
    vim.opt.expandtab = true -- follow the file convention for tab width
    vim.opt.smarttab = true -- smart tabs
    vim.opt.tabstop = 4 -- tab is 4 chars
    vim.opt.shiftwidth = 4 -- indents should be 4 chars
    vim.opt.softtabstop = 4 -- tabs are 4 chars

    --- search
    vim.o.ignorecase = true -- ignore case on search
    vim.opt.incsearch = true -- show substitution preview in buffer

    --- undo history (reserve undos after neovim closes)
    local undo_dir = vim.fn.stdpath("cache") .. "/undo/" -- undo dir path
    vim.fn.mkdir(undo_dir, "p") -- create undo dir
    vim.opt.undodir = undo_dir -- set undo dir
    vim.opt.undofile = true -- enable undo file
    vim.opt.undolevels = 1000 -- undo history to keep
end

return M
