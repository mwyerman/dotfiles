return {
  "brenoprata10/nvim-highlight-colors",
  event = "BufRead",
  cond = not vim.g.vscode,
  opts = {
    render = 'background',
  }
}
