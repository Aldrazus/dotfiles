local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
    'rust_analyzer',
    'volar',
    'pyright',
    'denols',
    'clangd'
})

lsp.set_sign_icons({})

local nvim_lsp = require('lspconfig')

-- (Optional) Configure lua language server for neovim
nvim_lsp.lua_ls.setup(lsp.nvim_lua_ls())

-- Run denols only in deno projects 
-- TODO: deno supports package.json, so...
nvim_lsp.denols.setup {
    root_dir = nvim_lsp.util.root_pattern('deno.json', 'deno.jsonc'),
}

-- Run tsserver only in node projects
nvim_lsp.tsserver.setup {
    root_dir = nvim_lsp.util.root_pattern('package.json'),
    single_file_support = false
}

lsp.setup()

local cmp = require('cmp')

cmp.setup {
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm {select = false },
    }
}

local rust_tools = require('rust-tools')
-- initialize rust_analyzer with rust-tools
local rust_lsp = lsp.build_options('rust_analyzer', {
    on_attach = function(_, bufnr)
        -- Hover actions
        vim.keymap.set("n", "<C-h>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
    end,
})

rust_tools.setup({
    server = rust_lsp,
    dap = {
        adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
            env = {
                CARGO_MANIFEST_DIR = "${workspaceFolder}"
            }
        }
    }
})

local dapui = require('dapui')
dapui.setup()
