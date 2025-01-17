local M = {}

local function is_neovide()
    if vim.g.neovide then
        return true
    end
    return false
end

M.setup = function()
    -- only do this if we are in neovide
    if not is_neovide() then
        return
    end

    vim.o.guifont = "FiraCode NF:h12"
    vim.g.neovide_position_animation_length = 0.15
    vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_scroll_animation_far_lines = 9999
    vim.g.neovide_confirm_quit = true

    vim.cmd.cd("~")
end

return M
