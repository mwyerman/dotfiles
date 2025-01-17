local M = {}

M.setup = function()
    --- options
    vim.g.newtrw_keepdir = 0 -- keep current dir and browsing dir synced
    vim.g.netrw_liststyle = 1
    vim.g.netrw_banner = 0 -- disable banner, temp toggle with I
    vim.g.netrw_localcopydircmd = "cp -r" -- recursive copy, TODO windows
    vim.g.netrw_localmkdir = "mkdir -p" -- recursive mkdir
    vim.g.netrw_localrmdir = "rm -r" -- recursive rm directory
    vim.g.netrw_sizestype = "H" -- human readable sizes
    vim.g.netrw_sort_sequence = [[[\/]$,*]] -- directories first, TODO fix in windows
    vim.cmd("hi! link netrwMarkFile Search") -- highlight marked files

    vim.api.nvim_create_autocmd("filetype", {
        pattern = "netrw",
        desc = "Better mappings for netrw",
        callback = function()
            local bind = function(lhs, rhs)
                vim.keymap.set(
                    "n",
                    lhs,
                    rhs,
                    { remap = true, buffer = true, nowait = true }
                )
            end
            -- bind('h', '-') -- go to parent dir
            -- bind('l', '<cr>') -- open directory/file
        end,
    })
end

return M
