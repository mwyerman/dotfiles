return {
  "github/copilot.vim",
  config = function()
    -- config copilot to use shift-tab instead of tab
    vim.cmd([[
    imap <silent><script><expr> <S-tab> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true
    ]])
  end
}
