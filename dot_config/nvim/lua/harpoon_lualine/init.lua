local M = require("lualine.component"):extend()
local highlight = require("lualine.highlight")

local default_options = {
    -- max_length = 0,
    -- tab_max_length = 40,
    -- mode = 0,
    -- use_mode_colors = false,
    -- path = 0,
    tabs_color = {
        active = nil,
        inactive = nil,
    },
}


-- This function is duplicated in buffers
---returns the proper hl for tab in section. Used for setting default highlights
---@param section string name of section tabs component is in
---@param is_active boolean
---@return string hl name
local function get_hl(section, is_active)
    local suffix = is_active and highlight.get_mode_suffix() or '_inactive'
    local section_redirects = {
        lualine_x = 'lualine_c',
        lualine_y = 'lualine_b',
        lualine_z = 'lualine_a',
    }
    if section_redirects[section] then
        section = highlight.highlight_exists(section .. suffix) and section or section_redirects[section]
    end
    return section .. suffix
end

function M:init(options)
    M.super.init(self, options)

    -- if use_mode_colors is set, use a function so that the colors update
    local default_active = options.use_mode_colors
        and function()
            return get_hl('lualine_' .. options.self.section, true)
        end
        or get_hl('lualine_' .. options.self.section, true)
    default_options.tabs_color = {
        active = default_active,
        inactive = get_hl('lualine_' .. options.self.section, false),
    }
    self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)
    -- stylua: ignore
    self.highlights = {
        active = self:create_hl(self.options.tabs_color.active, 'active'),
        inactive = self:create_hl(self.options.tabs_color.inactive, 'inactive'),
    }
end

--- Get what side we are on
--- @return "left" | "right"
function M:get_side()
    if self.options.self.section < "x" then
        return "left"
    else
        return "right"
    end
end

--- Get the separator
--- @return string
function M:get_separator()
    if self:get_side() == "left" then
        return self.options.component_separators.left
    else
        return self.options.component_separators.right
    end
end

--- Get active/inactive highights
--- @param is_active boolean
--- @return string
function M:get_hl(is_active)
    return highlight.component_format_highlight(self.highlights[(is_active and 'active' or 'inactive')])
end

--- Apply padding to the string
--- @param text string
--- @return string
function M:apply_padding(text)
    if text == nil then
        return ""
    end
    local l_padding, r_padding = 1, 1
    if type(self.options.padding) == "number" then
        l_padding, r_padding = self.options.padding, self.options.padding
    elseif type(self.options.padding) == "table" then
        l_padding, r_padding = self.options.padding.left or 0, self.options.padding.right or 0
    end
    return string.rep(" ", l_padding) .. text .. string.rep(" ", r_padding)
end

--- Shorten a filepath, using only single letters for directories
--- @param filepath string
--- @return string
local function shorten_path(filepath)
    -- Handle Windows paths by replacing '\' with '/'
    filepath = filepath:gsub("\\", "/")

    -- Split the filepath into components
    local components = {}
    for component in filepath:gmatch("[^/]+") do
        table.insert(components, component)
    end

    -- Reduce each component to the first letter
    for i, component in ipairs(components) do
        if i == #components then
            components[i] = component
        else
            if component:sub(1, 1) == '.' then
                -- For dotfiles, keep a second letter
                components[i] = component:sub(1, 2)
            else
                components[i] = component:sub(1, 1)
            end
        end
    end

    -- Rejoin the components back into a shortened path
    return table.concat(components, "/")
end

function M:update_status()
    local ok, harpoon = pcall(require, "harpoon")
    if not ok then
        return
    end

    local active_buffer = vim.api.nvim_buf_get_name(0)
    local working_dir = vim.fn.getcwd()
    local separator = self:get_separator()

    ---@type {[integer]: {index: integer, path: string, is_active: boolean }}
    local marks = {}
    local harpoon_list = harpoon:list()
    for i, mark in ipairs(harpoon_list.items) do
        local filepath = working_dir .. "/" .. mark.value
        table.insert(marks, { index = i, path = mark.value, is_active = filepath == active_buffer })
    end

    ---@type {[integer]: string}
    local labels = {}
    ---@type 'active' | 'inactive'
    for i, mark in ipairs(marks) do
        if i > 1 then
            table.insert(labels, separator)
        end

        if mark.is_active then
            table.insert(labels, self:get_hl(true))
        elseif i == 1 then
            table.insert(labels, self:get_hl(false))
        end

        local label = self:apply_padding(mark.index .. ": " .. shorten_path(mark.path))
        table.insert(labels, label)

        if mark.is_active then
            table.insert(labels, self:get_hl(false))
        end
    end

    local res = table.concat(labels)
    -- print(res)
    return res
end

return M
