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
      python = { "ruff" },
      sh = { "shellcheck" },
      yaml = { "yamllint" },
      c = { "cppcheck" }
    }
  end
}
