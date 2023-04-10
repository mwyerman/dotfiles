local function set_diagnostic_signs()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
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
    { "<leader>li", "<cmd>LspInfo<cr>",                                 desc = "lsp info" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = false})<cr>", desc = "format" },
    { "gl",         "<cmd>lua vim.diagnostic.open_float()<cr>",         desc = "show diagnostic" },
    { "gr",         "<cmd>lua vim.lsp.buf.references()<cr>",            desc = "references" },
    { "gd",         "<cmd>lua vim.lsp.buf.definition()<cr>",            desc = "definition" },
    { "gD",         "<cmd>lua vim.lsp.buf.declaration()<cr>",           desc = "declaration" },
    { "K",          "<cmd>lua vim.lsp.buf.hover()<cr>",                 desc = "hover" },
    { "gj",         "<cmd>lua vim.diagnostic.goto_next()<cr>",          desc = "next diagnostic" },
    { "gk",         "<cmd>lua vim.diagnostic.goto_prev()<cr>",          desc = "prev diagnostic" },
  },
  -- lazy = false,
  event = "BufReadPre",
  config = function()
    set_diagnostic_signs()
    set_diagnostic_config()
  end
}
