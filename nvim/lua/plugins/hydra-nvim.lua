return {
  "anuvyklack/hydra.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    local hydra = require("hydra")
    local gitsigns = require("gitsigns")

    -- git submode

    local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      _r_: reset hunk     _/_: show base file
 ^ ^              ^ ^                    _R_: reset buffer
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
    ]]

    hydra({
      name = "git",
      hint = hint,
      config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
          border = "rounded",
        },
        on_enter = function()
          if vim.cmd 'mkview' then
            vim.cmd 'silent! %foldopen'
            vim.bo.modifiable = false
            gitsigns.toggle_linehl(true)
          end
        end,
        on_exit = function()
          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          vim.cmd 'loadview'
          vim.api.nvim_win_set_cursor(0, cursor_pos)
          vim.cmd 'normal zv'
          gitsigns.toggle_linehl(false)
          gitsigns.toggle_deleted(false)
        end,
      },
      mode = { "n", "x" },
      body = "<leader>g",
      heads = {
        { "J",
          function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return "<ignore>"
          end,
          expr = true, desc = "next hunk"
        },
        { "K",
          function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return "<ignore>"
          end,
          expr = true, desc = "prev hunk"
        },
        { "s", gitsigns.stage_hunk, desc = "stage hunk" },
        { "u", gitsigns.undo_stage_hunk, desc = "undo stage hunk" },
        { "S", gitsigns.stage_buffer, desc = "stage buffer" },
        { "p", gitsigns.preview_hunk, desc = "preview hunk" },
        { "d", gitsigns.toggle_deleted, desc = "toggle_deleted" },
        { "b", gitsigns.blame_line, desc = "blame line" },
        { "B", function() gitsigns.blame_line { full = true } end, desc = "blame line (full)" },
        { "r", gitsigns.reset_hunk, desc = "reset hunk" },
        { "R", gitsigns.reset_buffer, desc = "reset buffer" },
        { "/", gitsigns.show, { exit = true }, desc = "show base file" },
        { "<Enter>", "<cmd>Neogit<CR>", { exit = true, desc = "open neogit" } },
        { "q", nil, { exit = true, nowait = true, desc = "quit" } },

      }
    })

  end
}
