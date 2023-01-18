local options = {
  clipboard = unnamedplus, -- set clipboard

  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab

  number = true, -- enable line numbers
  relativenumber = true, -- enable relative linenumbers

  scrolloff = 8, -- keep 8 lines visible above/below cursor when scrolling
  sidescrolloff = 8, -- keep 8 rows visible beside cursor when sidescrolling

  ignorecase = true, -- ignore case when searching
  smartcase = true, -- override ignorecase if capitals in search term

  list = true, -- show hidden chars
  listchars = "tab:◀■▶,trail:·,extends:◣,precedes:◢,nbsp:○",

  mouse = "a", -- enable mouse
  cursorline = true, -- show line beneath cursor
  wrap = false, -- disable linewrap
  hidden = true, -- disable hidden buffers
  completeopt = { "menu", "menuone", "noselect" }, -- for cmp
  conceallevel = 0, -- so `` is visible in md files
  fileencoding = "utf-8",
  pumheight = 10, -- popup menu height
  showtabline = 2, -- always show tab bar
  timeoutlen = 50,

  splitbelow = true,
  splitright = true,

  termguicolors = true,

  undofile = true, -- persistent undo
  updatetime = 50, -- faster completion
  numberwidth = 4,
  signcolumn = "yes",
  guifont = "monospace:h17",

}

for k, v in pairs(options) do
  vim.opt[k] = v
end
