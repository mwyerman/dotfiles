return {
  "neovim/nvim-lspconfig",
  keys = {
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "lsp info" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = false})<cr>", desc = "lsp info" },
  },
  lazy = false,
}
