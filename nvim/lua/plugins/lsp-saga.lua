return {
  "glepnir/lspsaga.nvim",
  keys = {
    { "<leader>l.", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next diagnostic" },
    { "<leader>l,", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "prev diagnostic" },
    { "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next diagnostic" },
    { "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "prev diagnostic" },
    { "<leader>ll", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "line diagnostics" },
    { "<leader>lc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", desc = "cursor diagnostics" },
    { "<leader>lb", "<cmd>Lspsaga show_buffer_diagnostics<cr>", desc = "buffer diagnostics" },
    { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "code action" },
    { "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "rename" },
    { "gr", "<cmd>Lspsaga lsp_finder<cr>", desc = "references" },
    { "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "line diagnostics" },
    { "gL", "<cmd>Lspsaga show_cursor_diagnostics<cr>", desc = "cursor diagnostics" },
    { "gb", "<cmd>Lspsaga show_buffer_diagnostics<cr>", desc = "buffer diagnostics" },
    { "gd", "<cmd>Lspsaga peek_definition<cr>", desc = "peek definition" },
    { "gD", "<cmd>Lspsaga goto_definition<cr>", desc = "goto definition" },
    { "g.", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next diagnostic" },
    { "g,", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "prev diagnostic" },
    { "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next diagnostic" },
    { "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "prev diagnostic" },
    { "K", "<cmd>Lspsaga hover_doc<cr>" }
  },
  event = "BufRead",
  config = function()
    local catppuccin = require("catppuccin.groups.integrations.lsp_saga")
    require("lspsaga").setup({
      preview = {
        lines_above = 0,
        lines_below = 10,
      },
      scroll_preview = {
        scroll_down = "<C-j>",
        scroll_up = "<C-k>",
      },
      request_timeout = 2000,
      ui = {
        colors = catppuccin.custom_colors(),
        kind = catppuccin.custom_kind(),
      }
    })
  end
}
