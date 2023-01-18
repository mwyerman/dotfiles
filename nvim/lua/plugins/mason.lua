return {
  "williamboman/mason.nvim",
  keys = {
    { "<leader>lI", "<cmd>Mason<cr>", desc = "mason installer" }
  },
  lazy = false,
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")

    require("mason").setup()
    require("mason-lspconfig").setup()
    require("mason-lspconfig").setup_handlers({
      -- Default handler (optional)
      function(server_name)
        lspconfig[server_name].setup({})
      end,

      ["pylsp"] = function()
        lspconfig["pylsp"].setup(
          require("lsp.settings.pylsp")
        )
      end,
      ["sumneko_lua"] = function()
        lspconfig["sumneko_lua"].setup(
          require("lsp.settings.sumneko_lua")
        )
      end,
      ["clangd"] = function()
        lspconfig["clangd"].setup(
          require("lsp.settings.clangd")
        )
      end,

    })
  end,
}
