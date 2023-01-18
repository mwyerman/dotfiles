return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    vim.opt.termguicolors = true
    require("catppuccin").setup({
      colorscheme = "mocha",
      integrations = {
        cmp = true,
        lsp_saga = true,
        telescope = true,
        gitsigns = true,
        nvimtree = true,
        mini = true,
        bufferline = true,
        hop = true,
        neogit = true,
      },
      custom_highlights = function(colors)
        return {
          TabLineSel = { fg = colors.base, bg = colors.red },
          TabLine = { fg = colors.base, bg = colors.base },
          TabLineFill = { fg = colors.base, bg = colors.base },
        }
      end
    })
    local colors = require("catppuccin.palettes").get_palette()
    vim.api.nvim_set_hl(0, 'TabLineSel', { fg = colors.base, bg = colors.red })
  end
}
