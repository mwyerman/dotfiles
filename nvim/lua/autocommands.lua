vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end
]]

vim.cmd [[
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end
]]

vim.cmd [[
  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end
]]

vim.cmd [[
  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end
]]

vim.cmd [[
  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]

-- change commentstring to use // for c, h, cpp, and hpp files
vim.cmd [[
  augroup _commentstring
    autocmd!
    autocmd BufEnter *.{c,h,cpp,hpp} setlocal commentstring=//\ %s
]]

local function temp(client)
    print(client.name)
  return true




end

-- autoformat on save
vim.cmd [[
  augroup _autoformat
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format({async = false, filter = temp})
  augroup end
]]
