vim.pack.add({"https://github.com/j-hui/fidget.nvim"})
require('fidget').setup({
  notification = {
    window = {
      border = "rounded",
      winblend = 100
    }
  }
})

-- LSP default configs
vim.pack.add({"https://github.com/neovim/nvim-lspconfig"})

-- LSP package manager
vim.pack.add({"https://github.com/mason-org/mason.nvim"})
vim.pack.add({"https://github.com/mason-org/mason-lspconfig.nvim"})

-- Snippets
vim.pack.add({"https://github.com/rafamadriz/friendly-snippets"})
vim.pack.add({"https://github.com/folke/lazydev.nvim"})
vim.pack.add({"https://github.com/saghen/blink.cmp"})

require('blink.cmp').setup({
  keymap = { preset = "enter" },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  cmdline = {
    enabled = false,
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      }
    }
  },
  completion = {
    menu = {
      winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
    }
  }
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { "clangd", "neocmake", "lua_ls", "vue_ls", "vtsls" }
})

local function set_global_keymaps(client, bufnr)
  local map = vim.keymap.set

  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "K", vim.lsp.buf.hover, opts("Hover Documentation"))
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
  map("n", "<leader>rn", vim.lsp.buf.rename, opts("[r]e[n]ame"))
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("[c]ode [a]ction"))

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })

  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts("List workspace folders"))
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('global.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    set_global_keymaps(client, bufnr)
  end
})

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
