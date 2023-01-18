return {
  "danymat/neogen",
  keys = {
    { "<leader>d", "<cmd>lua require('neogen').generate()<CR>", mode = "n", desc = "generate docstring" },
  },
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
