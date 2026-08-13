local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Tabs and indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.clipboard = "unnamedplus"

-- Appearance
opt.termguicolors = true
opt.scrolloff = 8
opt.cursorline = true

-- Center after page down / up
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Move to the split above" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Move to the split below" })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Move to the left split" })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Move to the right split" })

-- Navigate vim panes with Ctrl+Shift+Arrow
vim.keymap.set("n", "<C-S-Up>", ":wincmd k<CR>", { desc = "Move to the split above" })
vim.keymap.set("n", "<C-S-Down>", ":wincmd j<CR>", { desc = "Move to the split below" })
vim.keymap.set("n", "<C-S-Left>", ":wincmd h<CR>", { desc = "Move to the left split" })
vim.keymap.set("n", "<C-S-Right>", ":wincmd l<CR>", { desc = "Move to the right split" })

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save Buffer" })

-- Lazy menu
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { desc = "Launch Lazy" })
