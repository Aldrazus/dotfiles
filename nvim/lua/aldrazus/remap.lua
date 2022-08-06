local keymap = require('aldrazus.keymap')
local nnoremap = keymap.nnoremap
local inoremap = keymap.inoremap

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

nnoremap('<leader>pv', '<cmd>Ex<CR>')



