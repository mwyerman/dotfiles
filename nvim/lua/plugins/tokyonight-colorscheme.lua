return {
  "folke/tokyonight.nvim",
  lazy = true,
  cond = not vim.g.vscode,
  config = function()
    vim.g.tokyonight_style = "night"
  end
}
