return {
  "smjonas/inc-rename.nvim",
  keys = {
    { "<leader>lr", ":IncRename ", desc = "rename" },
  },
  cond = not vim.g.vscode,
  config = function()
    require("inc_rename").setup()
  end
}
