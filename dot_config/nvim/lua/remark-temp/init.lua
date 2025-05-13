--- @class Mark
--- @field path string
--- @field row integer
--- @field col integer
local Mark
Mark.__index = Mark

--- @param o any
--- @param t string
--- @param msg string
local function is_type(o, t, msg)
    if type(o) ~= t then
        error(msg .. ". Expected type " .. t .. ", got " .. type(o) .. ": " .. (o or "null"))
    end
end

function Mark:new(path, row, col)
    local o = setmetatable({}, self)
    self.path = path
    self.row = row
    self.col = col
    return o
end

--- Go to the file/location the mark is pointing to
function Mark:go_to()
    vim.cmd("e " .. self.path)
    vim.api.nvim_win_set_cursor(0, { self.row, self.col })
end

--- Get the mark as a string
--- @return string
function Mark:display()
    return self.path .. " [" .. self.row .. ":" .. self.col .. "]"
end

-- --- @class Remark
local M = {}

function M.setup()
    -- MarkTable = {}
    M.db = require("sqlite3").open_memory()
end

--- Create a mark
--- @param key string
--- @param path string
--- @param row number
--- @param col number
function M.add_mark(key, path, row, col)
    is_type(key, "string", "Key error")
    is_type(path, "string", "Path error")
    is_type(row, "number", "Row error")
    is_type(col, "number", "Col error")
    local mark = Mark:new(path, row, col)
    if MarkTable[path] == nil then
        MarkTable[path] = {}
    end
    MarkTable[path][key] = mark
end

--- Get a mark from a key
--- @param key string
--- @param path string
--- @return Mark | nil
function M.get_mark(key, path)
    local mark_table = MarkTable[path]
    if mark_table == nil then
        return nil
    end

    return mark_table[key]
end

--- List all marks
--- @return { [string]: Mark }
function M.list_marks()
    return MarkTable
end

return M
