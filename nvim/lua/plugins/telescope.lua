-- change build command for windows
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  keys = {
    { "<leader>b",  ":Telescope buffers<cr>",                       desc = "buffers" },
    { "<leader>f",  ":Telescope find_files<cr>",                    desc = "files" },
    { "<leader>F",  ":Telescope live_grep<cr>",                     desc = "grep" },
    -- { "<leader>go", ":Telescope git_status<cr>", desc = "modified files" },
    -- { "<leader>gb", ":Telescope git_branches<cr>", desc = "branches" },
    -- { "<leader>gc", ":Telescope git_commits<cr>", desc = "commits" },
    { "<leader>ls", ":Telescope lsp_document_symbols<cr>",          desc = "document symbols" },
    { "<leader>lS", ":Telescope lsp_dynamic_workspace_symbols<cr>", desc = "workspace symbols" },
    { "<leader>Sc", ":Telescope colorscheme<cr>",                   desc = "colorschemes" },
    { "<leader>Sh", ":Telescope help_tags<cr>",                     desc = "help tags" },
    { "<leader>Sk", ":Telescope keymaps<cr>",                       desc = "keymaps" },
    { "<leader>SC", ":Telescope commands<cr>",                      desc = "commands" },
    { "<leader> ",  ":Telescope resume<cr>",                        desc = "resume" },
  },
  cmd = { "Telescope" },
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build =
      "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  cond = not vim.g.vscode,
  config = function()
    local actions = require("telescope.actions")

    local extensions = {
      ["ui-select"] = {
          require("telescope.themes").get_dropdown {
        }
      }
    }
    local windows = vim.fn.has "win32" == 1

    if not windows then
      extensions.fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    end

    require("telescope").setup {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-l>"] = actions.cycle_history_next,
            ["<C-h>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,
            ["?"] = actions.which_key,
          },
        },
      },
      pickers = {},
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {

          }
        },
      },
    }

    if not windows then
      require("telescope").load_extension "fzf"
    end
    require("telescope").load_extension "ui-select"
  end,
}
