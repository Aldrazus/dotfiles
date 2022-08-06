vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', {noremap = true, silent = true})
vim.g.mapleader = ' '

vim.opt.fileencoding = 'UTF-8'
vim.opt.encoding = 'UTF-8'

vim.opt.showmode = false 
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.backupcopy = 'yes'
vim.opt.undodir = '~/.vim/undodir'
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.signcolumn = 'number'
vim.opt.cmdheight = 2
vim.opt.updatetime = 50
vim.opt.mouse = 'a'
vim.opt.showtabline = 1
vim.opt.inccommand = 'split'
vim.opt.cmdheight = 2
vim.opt.shortmess:append('c')
vim.cmd('syntax on')

-- highlight Comment cterm=italic gui=italic
-- Unfortunately, nvim_set_hl() replaces a highlight group's definition
-- vim.api.nvim_set_hl(0, 'Comment', {italic = true})

-- syntax on
