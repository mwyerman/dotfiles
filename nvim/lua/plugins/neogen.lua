return {
  "danymat/neogen",
  keys = {
    { "<leader>D", "<cmd>lua require('neogen').generate()<CR>", mode = "n", desc = "generate docstring" },
  },
  cond = not vim.g.vscode,
  opts = {
    enabled = true,
    input_after_comment = true,
    languages = {
      python = {
        template = {
          annotation_convention = "numpydoc",
        }
      }
    },
  }
}
