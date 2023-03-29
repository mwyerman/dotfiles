return {
  "smjonas/inc-rename.nvim",
  keys = {
    { "<leader>lr", ":IncRename ", desc = "rename" },
  },
  config = function()
    require("inc_rename").setup()
  end
}
