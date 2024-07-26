return {
  "folke/which-key.nvim",
  cond = not vim.g.vscode,
  opts = {
    spec = {
      { "<leader>Q", "<cmd>q!<cr>", desc = "quit!", nowait = true, remap = false },
      { "<leader>T", group = "terminal", nowait = true, remap = false },
      { "<leader>W", "<cmd>w<cr>", desc = "write", nowait = true, remap = false },
      { "<leader>h", "<cmd>nohlsearch<cr>", desc = "no highlight", nowait = true, remap = false },
      { "<leader>l", group = "lsp", nowait = true, remap = false },
      { "<leader>p", "<cmd>Lazy<cr>", desc = "lazy", nowait = true, remap = false },
      { "<leader>q", "<cmd>q<cr>", desc = "quit", nowait = true, remap = false },
      { "<leader>s", "<cmd>split<cr>", desc = "hsplit", nowait = true, remap = false },
      { "<leader>t", "<cmd>term<cr>", desc = "terminal", nowait = true, remap = false },
      { "<leader>v", "<cmd>vsplit<cr>", desc = "vsplit", nowait = true, remap = false },
      { "<leader>w", group = "write", nowait = true, remap = false },
      { "<leader>wq", "<cmd>wq<cr>", desc = "write and quit", nowait = true, remap = false },
      { "<leader>ww", "<cmd>w<cr>", desc = "write", nowait = true, remap = false },
    }
  }
}
