local Path = require("plenary.path")
local scope_ = require("remark.scope")

--- @class Mark
--- @field id number?: Unique ID
--- @field key string: Key mapped to this mark
--- @field scope_path string: Scope of the mark; either a file or a parent directory
--- @field destination string: Filename the mark points to
--- @field row number: Row number the mark points to
--- @field col number: Column number the mark points to
Mark = {}
Mark.__index = Mark

--- Create a new Mark
--- @param id number?
--- @param key string
--- @param scope_path string
--- @param destination string
--- @param row number
--- @param col number
--- @return Mark
function Mark:new(id, key, scope_path, destination, row, col)
    return setmetatable({
        id = id,
        key = key,
        scope = scope_path,
        destination = destination,
        row = row,
        col = col,
    }, self)
end


--- Create a new mark from the current position
--- @param key string
--- @param scope Scope
--- @return Mark
function Mark:from_current_position(key, scope)
    local active_file = vim.api.nvim_buf_get_name(0)
    local scope_path = scope_.resolve_path(scope)
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))

    return Mark:new(nil, key, scope_path, active_file, r, c)
end

--- Jump to the mark's position
function Mark:goto()
    local active_file = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
    local destination = vim.fn.fnameescape(self.destination)
    if active_file ~= destination then
        -- only change file if it isn't already open
        vim.cmd("edit" .. destination)
    end
    vim.api.nvim_win_set_cursor(0, { self.row, self.col })
end

--- Convert the mark to a 1-line string
--- @return string
function Mark:__tostring()
    return self.scope_path
        .. " | "
        .. self.key
        .. " -> "
        .. self.destination
        .. " ["
        .. tostring(self.row)
        .. ":"
        .. tostring(self.col)
        .. "]"
end

return Mark
