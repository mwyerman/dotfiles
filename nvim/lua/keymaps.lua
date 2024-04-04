local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal Mode
if not vim.g.vscode then
	-- better window navigation
	keymap("n", "<C-h>", "<C-w>h", opts)
	keymap("n", "<C-j>", "<C-w>j", opts)
	keymap("n", "<C-k>", "<C-w>k", opts)
	keymap("n", "<C-l>", "<C-w>l", opts)

	-- resize windows with arrows
	keymap("n", "<C-Up>", ":resize +2<cr>", opts)
	keymap("n", "<C-Down>", ":resize -2<cr>", opts)
	keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
	keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

	-- navigate buffers
	keymap("n", "<S-l>", ":bnext<cr>", opts)
	keymap("n", "<S-h>", ":bprevious<cr>", opts)

	-- improve netrw mappings
	vim.api.nvim_create_autocmd("filetype", {
		pattern = "netrw",
		desc = "Better mappings for netrw",
		callback = function()
			local bind = function(lhs, rhs)
				vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
			end

			bind("n", "%") -- edit new file
			bind("r", "R") -- rename file

			-- split navigation
			bind("<C-h>", "<C-w>h")
			bind("<C-j>", "<C-w>j")
			bind("<C-k>", "<C-w>k")
			bind("<C-l>", "<C-w>l")
		end,
	})
end

-- Visual Mode
-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- paste without clearing register
keymap("v", "P", '"_dP', opts)

-- Terminal Mode
-- exit terminal mode
keymap("t", "<C-\\>", "<C-\\><C-n>", opts)
