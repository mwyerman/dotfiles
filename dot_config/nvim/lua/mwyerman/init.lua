require("mwyerman.settings").setup()
require("mwyerman.neovide").setup()
require("mwyerman.keymap").setup()
require("mwyerman.lazy").setup()
require("mwyerman.terminal").setup()

-- require("nvim-recents").setup()
-- require("statusline").setup()


-- local function bindn(key, action, desc)
--     vim.keymap.set("n", key, action, { ["desc"] = desc })
-- end
-- local remark = require("remark")
-- remark.setup()
--
-- bindn("m", function ()
--     local char = vim.fn.getcharstr()
--     if char:match("[%a]") then
--         local file = vim.api.nvim_buf_get_name(0)
--         local pos = vim.api.nvim_win_get_cursor(0)
--         remark.add_mark(char, file, pos[1], pos[2])
--     end
-- end, "create mark")
--
-- bindn("M", function ()
--     local char = vim.fn.getcharstr()
--     if char:match("[%a]") then
--         local file = vim.api.nvim_buf_get_name(0)
--         local mark = remark.get_mark(char, file)
--         if not mark then
--             return
--         end
--         mark:go_to()
--     end
-- end, "create mark")
--
--
