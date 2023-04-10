return {
  "echasnovski/mini.nvim",
  event = "BufRead",
  keys = {
    { "<leader>x", "<cmd>lua MiniBufremove.delete()<cr>", "close file" },
  },
  config = function()
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
    require("mini.ai").setup()
    require("mini.pairs").setup()
  end
}
