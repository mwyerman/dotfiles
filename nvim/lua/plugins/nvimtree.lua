return {
  "kyazdani42/nvim-tree.lua",
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", mode = "n", desc = "toggle file explorer" },
  },
  cond = not vim.g.vscode,
  config = function()
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- set up defaults
      api.config.mappings.default_on_attach(bufnr)

      -- add custom mappings
      vim.keymap.set("n", "l", api.node.open.edit, opts("edit"))
      vim.keymap.set("n", "L", api.tree.change_root_to_node, opts("change root"))
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("collapse"))
      vim.keymap.set("n", "H", api.tree.change_root_to_parent, opts("change root to parent"))
      vim.keymap.set("v", "v", api.node.open.vertical, opts("vsplit"))
    end






    require("nvim-tree").setup {
      on_attach = on_attach,
      view = {
        width = 40,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        git_ignored = false,
      }
    }
  end
}
