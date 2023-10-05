return {
  "mhartington/formatter.nvim",
  config = function()
    local opts = {
      filetype = {
        lua = {
          require("formatter.filetypes.lua").stylua,
        },
        python = {
          require("formatter.filetypes.python").isort,
          require("formatter.filetypes.python").black,
        }
      }
    }

    require("formatter").setup(opts)

    vim.api.nvim_create_autocmd({
      "BufWritePost",
    }, {
      command = "FormatWrite",
    })
  end,
}
