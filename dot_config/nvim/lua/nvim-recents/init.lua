local M = {}

local recent_files_file = vim.fn.stdpath("cache") .. "/nvim-recent/files.txt"
local recent_dirs_file = vim.fn.stdpath("cache")
    .. "/nvim-recent/directories.txt"

M.setup = function() end

return M
