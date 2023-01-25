local function set_diagnostic_signs()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
end

local function set_diagnostic_config()
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
  })
end

return {
  "neovim/nvim-lspconfig",
  keys = {
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "lsp info" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = false})<cr>", desc = "lsp info" },
    { "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "show diagnostic" },
  },
  lazy = false,
  config = function()
    set_diagnostic_signs()
    set_diagnostic_config()
  end
}
