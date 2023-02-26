local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
    'rust_analyzer',
    'volar',
})

lsp.set_preferences({
    sign_icons = { }
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

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
