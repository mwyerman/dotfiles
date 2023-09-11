return {
  "kevinhwang91/nvim-ufo",
  keys = {
    { "zR", ":lua require('ufo').openAllFolds()<cr>",  "open all folds" },
    { "zM", ":lua require('ufo').closeAllFolds()<cr>", "close all folds" },
  },
  event = "BufRead",
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },
  cond = not vim.g.vscode,
  config = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    require("ufo").setup({
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    })
  end
}
