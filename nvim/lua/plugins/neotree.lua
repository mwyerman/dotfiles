return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	keys = {
		{ "<leader>e", ":Neotree position=current<CR>", desc = "neotree" },
		{ "<leader>E", ":Neotree toggle<CR>", desc = "neotree sidebar" },
		{ "<leader>d", ":Neotree diagnostics reveal toggle bottom<CR>", desc = "diagnostics" },
	},
	cmd = {
		"Neotree",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"mrbjarksen/neo-tree-diagnostics.nvim",
	},
	opts = {
    close_if_last_window = true,
		sources = {
			"filesystem",
			"buffers",
			"git_status",
			"diagnostics",
		},
		use_libuv_file_watcher = true,
		window = {
			mappings = {
				["l"] = "open",
				["L"] = "focus_preview",
				["h"] = "close_node",
				["<space>"] = "",
			},
		},
		filesystem = {
			filtered_items = {
				visible = true,
				never_show = {
					".git",
				},
			},
		},
	},
}
