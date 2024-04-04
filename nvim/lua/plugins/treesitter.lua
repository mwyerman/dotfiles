return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",                             -- update treesitter automatically
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring", -- comment.nvim treesitter support
    "m-demare/hlargs.nvim",                        -- highlight function arguments
  },
  cmd = { "TSInstall", "TSUpdate", "TSUninstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  event = "BufRead",
  cond = not vim.g.vscode,
  version = false,
  config = function()
    require("ts_context_commentstring").setup{}
    vim.g.skip_ts_context_commentstring_module = true
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "bash", "c", "cpp", "css", "dockerfile", "go", "html", "java", "javascript", "jsdoc", "json",
        "json5", "llvm", "lua", "make", "python", "rust", "typescript", "verilog", "vim" },
      sync_install = false,
      ignore_install = { "" }, -- list of parsers to ignore installing
      -- highlight = {
      --   enable = true,
      --   disable = { "" }, -- languages to disable
      --   additional_vim_regex_highlighting = false,
      -- },
      -- indent = { enable = true, disable = { "yaml", "python" } },
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<cr>",
      --     node_incremental = "<cr>",
      --     scope_incremental = "<s-cr>",
      --     node_decremental = "<bs>",
      --   },
      -- },
    }
  end
}
