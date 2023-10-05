return {
  "mfussenegger/nvim-lint",
  config = function()
    local nvimlint = require("lint")

    nvimlint.linters_by_ft = {
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
      javascript = { "eslint" },
      javascriptreact = { "eslint" },
      lua = { "luacheck" },
      python = { "flake8" },
      sh = { "shellcheck" },
      yaml = { "yamllint" },
      c = { "cppcheck" }
    }

    vim.api.nvim_create_autocmd({
      "InsertLeave",
      "BufWritePost",
    }, {
      callback = function()
        require("lint").try_lint(nil, { ignore_errors = true })
      end,
    })
  end
}
