return {
  "akinsho/bufferline.nvim",
  -- event = { "BufRead", "BufNewFile" },
  cond = not vim.g.vscode,
  config = function()
    local colors = require("catppuccin.palettes").get_palette()

    local text_active = {
      fg = colors.green,
      bg = colors.base,
    }
    local text_inactive = {
      fg = colors.text,
      bg = colors.base,
    }
    local err = {
      fg = colors.red,
      bg = colors.base,
    }
    local warning = {
      fg = colors.peach,
      bg = colors.base,
    }

    require("bufferline").setup({
      options = {
        -- basic options
        numbers = function(opts)
          return string.format('%s', opts.raise(opts.ordinal))
        end,
        show_duplicate_prefix = true,
        always_show_bufferline = true,
        sort_by = 'id',
        persist_buffer_sort = true,
        enforce_regular_tabs = true,
        indicator = {
          style = "underline",
        },
        -- icons
        separator_style = { "", "" },
        modified_icon = "●",
        left_trunc_marker = "",
        right_trunc_marker = "",
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        -- sizes
        max_name_length = 30,
        max_prefix_length = 27, -- prefix used when a buffer is de-duplicated
        tab_size = 30,
        -- diagnostics
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, _, _, _) -- args are (count, level, diagnostics_dict, context)
          return "(" .. count .. ")"
        end,
        offsets = { { filetype = "NvimTree", text = "File Explorer" } },
      },
      highlights = {
        -- selected is the currently active buffer
        -- visible is not active but still visible
        -- other category is for buffers that are not visible

        -- diagnostics reference the number of errors/warning/etc

        buffer_visible = text_inactive,
        buffer_selected = text_active,
        background = text_inactive, -- covors inactive buffers for some reason
        numbers = text_inactive,
        numbers_selected = text_active,
        numbers_visible = text_inactive,
        warning = text_inactive,
        warning_selected = warning,
        warning_visible = text_inactive,
        warning_diagnostic = warning,
        warning_diagnostic_selected = warning,
        warning_diagnostic_visible = warning,
        error = text_inactive,
        error_selected = err,
        error_visible = text_inactive,
        error_diagnostic = err,
        error_diagnostic_selected = err,
        error_diagnostic_visible = err,
        info = text_inactive,
        info_selected = warning,
        info_visible = text_inactive,
        info_diagnostic = warning,
        info_diagnostic_selected = warning,
        info_diagnostic_visible = warning,
        hint = text_inactive,
        hint_selected = warning,
        hint_visible = text_inactive,
        hint_diagnostic = warning,
        hint_diagnostic_selected = warning,
        hint_diagnostic_visible = warning,
      }
    })
  end
}
