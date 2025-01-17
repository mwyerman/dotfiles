return {
    "goolord/alpha-nvim",
    config = function()
        -- require('alpha').setup(require('alpha.themes.dashboard').config)
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        local telescope_builtin = require("telescope.builtin")

        dashboard.section.buttons.val = {
            dashboard.button("p", "projects", "<cmd>Telescope project<cr>"),
            dashboard.button("f", "find file", telescope_builtin.find_files),
            dashboard.button("g", "grep", telescope_builtin.live_grep),
            dashboard.button("c", "config", function()
                vim.cmd.e("$MYVIMRC")
                vim.cmd.cd("%:p:h")
                telescope_builtin.find_files()
            end),
            dashboard.button("q", "quit", ":qa<cr>"),
        }
        alpha.setup(dashboard.opts)
    end,
}
