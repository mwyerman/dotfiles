return {
  "B4mbus/oxocarbon-lua.nvim",
  lazy = true,
  config = function()
    vim.cmd([[
    augroup MyColors
    autocmd!
    autocmd ColorScheme oxocarbon-lua highlight Comment guifg=#be95ff
    augroup end
    ]])

    vim.o.termguicolors = true
    vim.g.oxocarbon_lua_keep_terminal = true
  end
}
