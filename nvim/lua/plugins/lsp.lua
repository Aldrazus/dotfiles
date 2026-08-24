local function set_global_keymaps(_, bufnr)
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

local function ensure_mason_packages(package_names)
  if #vim.api.nvim_list_uis() == 0 then
    return
  end

  local registry = require("mason-registry")
  registry.refresh(function(success)
    if not success then
      return
    end

    for _, package_name in ipairs(package_names) do
      local ok, package = pcall(registry.get_package, package_name)
      if ok and not package:is_installed() and not package:is_installing() then
        package:install()
      end
    end
  end)
end

return {
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          border = "rounded",
          winblend = 100,
        },
      },
    },
  },

  { "neovim/nvim-lspconfig",   lazy = false },
  { "mfussenegger/nvim-jdtls", ft = "java" },
  { "seblj/roslyn.nvim",       ft = "cs",   opts = {} },

  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      ensure_mason_packages({ "java-debug-adapter", "java-test" })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "clangd", "neocmake", "lua_ls", "vue_ls", "vtsls", "jdtls" },
      automatic_enable = {
        exclude = { "jdtls" },
      },
    },
  },

  { "rafamadriz/friendly-snippets", lazy = true },
  { "folke/lazydev.nvim",           ft = "lua", opts = {} },

  {
    "saghen/blink.cmp",
    version = "v1.10.1",
    dependencies = { "rafamadriz/friendly-snippets", "folke/lazydev.nvim" },
    opts = {
      keymap = {
        preset = "enter",
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      cmdline = {
        enabled = false,
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      completion = {
        menu = {
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      },
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("global.lsp", { clear = true }),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          set_global_keymaps(client, args.buf)
        end,
      })

      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
    end,
  },
}
