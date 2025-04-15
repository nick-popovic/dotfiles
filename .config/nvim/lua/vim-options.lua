vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Navigate vim panes with crtl+arrow keys
vim.keymap.set('n', '<c-up>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-down>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-left>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-right>', ':wincmd l<CR>')


vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

-- Set up the terminal
vim.keymap.set("n", "<Leader>t", ":botright 12split | terminal<CR>", { silent = true, noremap = true })