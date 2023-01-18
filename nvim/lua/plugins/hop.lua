return {
  "phaazon/hop.nvim",
  keys = { "S", "q" },
  config = function()
    require("hop").setup()
    vim.api.nvim_set_keymap("n", "S", ":HopPattern<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "q", ":HopWord<cr>", { noremap = true, silent = true })
  end,
}
