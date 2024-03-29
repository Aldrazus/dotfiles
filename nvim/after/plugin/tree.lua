require('nvim-tree').setup({
    sort_by = 'case_sensitive',
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
    on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings

    end
})

vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>', {})
