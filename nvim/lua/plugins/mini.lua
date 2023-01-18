return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.animate").setup()
    require("mini.bufremove").setup()
    require("mini.comment").setup()
    require("mini.indentscope").setup()
    require("mini.jump").setup()
    require("mini.move").setup({
      mappings = {
        left = "<S-h>",
        right = "<S-l>",
        up = "<S-k>",
        down = "<S-j>",
      }
    })
    require("mini.pairs").setup()
  end
}
