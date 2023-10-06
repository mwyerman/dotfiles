return {
	"phaazon/hop.nvim",
	keys = { "q" },
	config = function()
		require("hop").setup()
		vim.api.nvim_set_keymap("n", "q", ":HopWord<cr>", { noremap = true, silent = true })
	end,
}
