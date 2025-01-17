local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

local function get_mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

local function get_filepath()
    local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
    return string.format(" %%<%s/", fpath)
end

local function get_filename()
    local fname = vim.fn.expand("%:t")
    return fname
end

local function get_filetype()
    return string.format(" %s ", vim.bo.filetype)
end

local function get_linenumber()
    if vim.bo.filetype == "alpha" then
        return ""
    end
    return " L%l:C%c "
end

local function get_git()
    local gitinfo = vim.b.gitsigns_status_dict
    if not gitinfo or gitinfo.head == "" then
        -- either gitinfo not running
        -- or not a git repo
        return ""
    end

    local added = gitinfo.added and ("%#GitSignsAdd#+" .. gitinfo.added .. " ")
        or ""
    local changed = gitinfo.changed
            and ("%#GitSignsChange#~" .. gitinfo.changed .. " ")
        or ""
    local removed = gitinfo.removed
            and ("%#GitSignsDelete#-" .. gitinfo.removed .. " ")
        or ""
    if gitinfo.added == 0 then
        added = ""
    end
    if gitinfo.changed == 0 then
        changed = ""
    end
    if gitinfo.removed == 0 then
        removed = ""
    end

    if added == "" and changed == "" and removed == "" then
        return ""
    end

    return table.concat({
        "%#Normal#",
        " ",
        added,
        changed,
        removed,
    })
end

M = {}

M.active = function()
    return table.concat({
        "%#Statusline#",
        get_mode(),
        "%#Normal#",
        get_filepath(),
        get_filename(),
        "%=%#StatuslineExtra#",
        get_filetype(),
        get_git(),
        "%#Normal#",
        get_linenumber(),
    })
end

M.inactive = function()
    return " %F"
end

M.setup = function()
    local augroup = vim.api.nvim_create_augroup("statusline", { clear = true })

    local active_redraw_events = {
        "WinEnter",
        "BufEnter",
        "BufWritePost",
        "FileChangedShellPost",
        "FileType",
        "ModeChanged",
    }

    vim.api.nvim_create_autocmd(active_redraw_events, {
        pattern = "*",
        group = augroup,
        callback = function()
            vim.opt.statusline = M.active()
        end,
    })
    vim.api.nvim_create_autocmd({
        "WinLeave",
        "BufLeave",
    }, {
        pattern = "*",
        group = augroup,
        callback = function()
            vim.opt_local.statusline = M.inactive()
        end,
    })
end

return M
