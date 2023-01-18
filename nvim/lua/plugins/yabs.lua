return {
  "pianocomposer321/yabs.nvim",
  keys = {
    { "<leader>m", "<cmd>Telescope yabs tasks<cr>", mode = "n", desc = "yabs"},
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local cond = require("yabs.conditions")

    require("yabs").setup({
      languages = { -- List of languages in vim's `filetype` format
        lua = {
          tasks = {
            run = {
              command = 'luafile %', -- The command to run (% and other wildcards will be automatically expanded)
              type = 'vim',  -- The type of command (can be `vim`, `lua`, or `shell`, default `shell`)
            },
          },
        },
        c = {
          default_task = 'make',
        },
      },
      tasks = { -- Same values as `language.tasks`, but global
        make = {
          command = 'make',
          output = 'quickfix',
          condition = cond.file_exists('Makefile'),
        },
        ["make clean"] = {
          command = 'make clean',
          output = 'quickfix',
          condition = cond.file_exists('Makefile'),
        },
        ["make test"] = {
          command = 'make test',
          output = 'quickfix',
          condition = cond.file_exists('Makefile'),
        },
        ceedling = {
          command = 'ceedling',
          output = 'quickfix',
          condition = cond.file_exists('project.yml'),
        }
      },
      opts = { -- Same values as `language.opts`
        output_types = {
          quickfix = {
            open_on_run = 'always',
          },
        },
      },
    })

    require("telescope").load_extension('yabs')
  end
}
