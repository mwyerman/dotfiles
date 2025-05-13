local Mark = require("remark.mark")
local db = require("remark.data")
local scope_ = require("remark.scope")

--- Main module for the Remark plugin
local M = {}

--- @return string
local function collect_keypress()
    return vim.fn.nr2char(vim.fn.getchar())
end

--- @class Opts
--- @field dev boolean?

--- Function to set up the plugin
--- @param opts Opts
function M.setup(opts)
    -- Merge user options with defaults
    return
    opts = opts or {}

    vim.api.nvim_create_user_command("RemarkCreate", function(o)
        M.create_mark(o.fargs[1], o.fargs[2])
    end, { nargs = "+" })

    vim.api.nvim_create_user_command("RemarkClearMarks", function()
        db.clear_marks()
    end, {})

    vim.api.nvim_create_user_command("RemarkListAll", function()
        print(vim.inspect(scope))
        local res = db.marks:get({
            where = scope and { scope_path = scope_.resolve_path(scope) },
        })
        if #res == 0 then
            print("Marks table empty")
        else
            for _, mark in ipairs(res) do
                local m = Mark:new(mark.id, mark.key, mark.scope, mark.destination, mark.row, mark.col)
                print(tostring(m))
            end
        end
    end, {})

    if opts.dev then
        vim.keymap.set("n", "<leader>rR", function()
            vim.cmd("Lazy reload remark")
        end, { desc = "Reload the plugin", silent = true })
    end

    vim.keymap.set("n", "m", function()
        local char = collect_keypress()
        if char:match("[a-z]") then
            M.create_mark(char, "file")
        else
            vim.notify("Invalid mark key: " .. vim.inspect(char), vim.log.levels.WARN)
        end
    end, { desc = "Create a new mark", silent = true })

    vim.keymap.set("n", "'", function()
        local char = collect_keypress()
        if char:match("[a-z]") then
            M.goto_mark(char, "file")
        else
            vim.notify("Invalid mark key: " .. vim.inspect(char), vim.log.levels.WARN)
        end
    end, { desc = "Go to a mark", silent = true })
end

--- Create a new mark
--- @param key string: The key to map the mark to
--- @param scope Scope: The scope of the mark
function M.create_mark(key, scope)
    db.add_mark(Mark:from_current_position(key, scope))
end

--- Goto a mark for key & scope
--- @param key string: The key of the mark to go to
--- @param scope Scope: The scope of the mark
function M.goto_mark(key, scope)
    local mark = db.get_mark(key, scope_.resolve_path(scope))
    if mark then
        mark:goto()
    else
        vim.notify("No mark stored on key/scope: " .. vim.inspect({ key = key, scope = scope }), vim.log.levels.WARN)
    end
end

return M
