return {
  "folke/which-key.nvim",
  config = function()
    local opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }

    -- plugin specific keymaps are configured in their respective plugin files
    local mappings = {
      -- save close and quit commands
      c = { "<cmd>bd<cr>", "close file" },
      C = { "<cmd>bd!<cr>", "close file!" },
      q = { "<cmd>q<cr>", "quit" },
      Q = { "<cmd>q!<cr>", "quit!" },
      W = { "<cmd>w<cr>", "write" },
      h = { "<cmd>nohlsearch<cr>", "no highlight" },
      w = {
        name = "+write",
        w = { "<cmd>w<cr>", "write" },
        q = { "<cmd>wq<cr>", "write and quit" },
      },

      -- misc commands
      v = { "<cmd>vsplit<cr>", "vsplit" },
      s = { "<cmd>split<cr>", "hsplit" },
      p = { "<cmd>Lazy<cr>", "lazy" },

      -- folders
      g = { name = "+git" },
      l = { name = "+lsp" },
      T = { name = "+terminal" },
    }

    require("which-key").setup(mappings, opts)
    require("which-key").register(mappings, opts)
  end
}
