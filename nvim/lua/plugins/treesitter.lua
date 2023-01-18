return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- update treesitter automatically
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring", -- comment.nvim treesitter support
  },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "bash", "c", "cpp", "css", "dockerfile", "go", "html", "java", "javascript", "jsdoc", "json",
        "json5", "latex", "llvm", "lua", "make", "python", "rust", "typescript", "verilog", "vim" },
      sync_install = false,
      ignore_install = { "" }, -- list of parsers to ignore installing
      autopairs = {
        enable = true,
      },
      highlight = {
        enable = false,
        disable = { "" }, -- languages to disable
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { "yaml", "python" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          scope_incremental = "<s-cr>",
          node_decremental = "<bs>",
        },
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    }
  end
}
