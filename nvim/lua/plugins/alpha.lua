return {
	"goolord/alpha-nvim",
	cmd = "Alpha",
	event = "BufWinEnter",
	cond = not vim.g.vscode,
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[                               __                ]],
			[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
			[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
		}
		dashboard.section.buttons.val = {
			dashboard.button("f", "  find file", ":Telescope find_files <CR>"),
			dashboard.button("F", "  find text", ":Telescope live_grep <CR>"),
			dashboard.button("e", "  new file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("g", "  git", ":Neogit<CR>"),
			dashboard.button("r", "  recently used files", ":Telescope oldfiles <CR>"),
			dashboard.button("c", "  configuration", ":e ~/.config/nvim/init.lua <CR>"),
			dashboard.button("q", "  quit neovim", ":qa<CR>"),
		}

		local function footer()
			-- NOTE: requires the fortune-mod package to work
			-- local handle = io.popen("fortune")
			-- local fortune = handle:read("*a")
			-- handle:close()
			-- return fortune
			return "github.com/mwyerman"
		end

		dashboard.section.footer.val = footer()

		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		dashboard.opts.opts.noautocmd = true
		require("alpha").setup(dashboard.opts)
	end,
}
