vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', {noremap = true, silent = true})
vim.g.mapleader = ' '

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<CR>", { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<CR>", { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<CR>", { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', "<cmd>Telescope help_tags<CR>", { desc = 'Telescope help tags' })

-- TODO: add something for creating new files more quickly
