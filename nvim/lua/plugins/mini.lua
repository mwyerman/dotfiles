return {
	"echasnovski/mini.nvim",
	keys = {
		{ "<leader>x", ":lua MiniBufremove.delete()<cr>", desc = "close buf" },
	},
	lazy = false,
	config = function()
		require("mini.comment").setup()
		require("mini.ai").setup()
		require("mini.splitjoin").setup()
		require("mini.cursorword").setup()
		require("mini.jump").setup()
    require("mini.icons").setup()

		require("mini.move").setup({
			mappings = {
				left = "<S-h>",
				right = "<S-l>",
				up = "<S-k>",
				down = "<S-j>",
			},
		})

		require("mini.surround").setup({
			mappings = {
				add = "Sa",
				delete = "Sd",
				find = "Sf",
				find_left = "SF",
				highlight = "Sh",
				replace = "Sr",
				update_n_lines = "Sn",

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		})

		if not vim.g.vscode then
			require("mini.bufremove").setup()
			require("mini.indentscope").setup()

			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					fixme = {
						pattern = "%f[%w]()FIXME()%f[%W]",
						group = "MiniHipatternsFixme",
					},
					hack = {
						pattern = "%f[%w]()HACK()%f[%W]",
						group = "MiniHipatternsHack",
					},
					note = {
						pattern = "%f[%w]()NOTE()%f[%W]",
						group = "MiniHipatternsNote",
					},
					todo = {
						pattern = "%f[%w]()TODO()%f[%W]",
						group = "MiniHipatternsTodo",
					},

					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end
	end,
}
