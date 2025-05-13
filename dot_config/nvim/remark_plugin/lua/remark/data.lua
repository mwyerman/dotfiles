local sqlite = require("sqlite.db")
local tbl = require("sqlite.tbl")
local Mark = require("remark.mark")
local Path = require("plenary.path")

local path = Path:new(vim.fn.stdpath("data")) / "remark" / "remark.db"
path:mkdir()

--- @class RemarkDB
--- @field marks sqlite_tbl
--- @field get_mark function
--- @field add_mark function
--- @field print_marks function
--- @field clear_marks function

--- @type RemarkDB
local db = sqlite({
    uri = tostring(path),
    marks = {
        id = true,
        key = { "text", required = true },
        scope_path = { "text", required = true },
        destination = { "text", required = true },
        row = { "number", required = true },
        col = { "number", required = true },
    },
})

local marks = db.marks

--- Lookup a mark using the key and scope
--- @param key string
--- @param scope_path string
--- @return Mark?
function db.get_mark(key, scope_path)
    local response = marks:where({
        key = key,
        scope_path = scope_path,
    })
    if not response then
        return nil
    end
    return Mark:new(response.id, response.key, response.scope_path, response.destination, response.row, response.col)
end

--- Add a mark to the database
--- @param mark Mark: The mark to insert in the db
--- @return number: The id of the new mark
function db.add_mark(mark)
    mark.id = nil
    local m = db.get_mark(mark.key, mark.scope_path)
    if m then
        marks:update({ where = { id = m.id }, set = mark })
        mark.id = m.id
        return m.id
    else
        local id = marks:insert(mark)
        mark.id = id
        return id
    end
end

--- Print the marks to show the user
function db.print_marks()
    local res = marks:get()
    if #res == 0 then
        print("Marks table empty")
    else
        for _, mark in ipairs(res) do
            local m = Mark:new(mark.id, mark.key, mark.scope_path, mark.destination, mark.row, mark.col)
            print(tostring(m))
        end
    end
end

--- Clear all marks
function db.clear_marks()
    marks:drop()
end

return db
