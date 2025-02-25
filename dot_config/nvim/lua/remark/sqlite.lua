-- local sqlite3 = require("lsqlite3")

local M = {}

local CURRENT_VERSION = 1

function M.get_db()
    if M.db ~= nil then
        return M.db
    end

    local db = require("lsqlite3complete").open_memory()

    local version = 0
    for row in db:nrows("PRAGMA user_version") do
        version = row.user_version
    end

    if version == 0 then
        print("Creating schema")
        local create_sql = [[
CREATE TABLE files (
    path TEXT NOT NULL PRIMARY KEY
);

CREATE TABLE scopes (
    path TEXT NOT NULL
);

CREATE TABLE marks (
    id INTEGER PRIMARY KEY,
    file TEXT NOT NULL,
    scope TEXT NOT NULL,
    tag TEXT NOT NULL,
    row INTEGER NOT NULL,
    col INTEGER NOT NULL,
    FOREIGN KEY (file) REFERENCES file(path) ON DELETE CASCADE
    FOREIGN KEY (scope) REFERENCES scope(path) ON DELETE CASCADE
);

PRAGMA user_version = 1;
]]

        db:exec(create_sql)
        version = 1
    end

    M.db = db
    return db
end

return M
