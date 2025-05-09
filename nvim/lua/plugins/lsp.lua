return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },
    },
  },
  { "williamboman/mason.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "mason.nvim",
      "nvim-lspconfig",
      "blink.cmp",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls", "volar", "ts_ls" },
      })
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local capabilities = require("blink.cmp").get_lsp_capabilities()
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = require("config.lspconfig").on_attach,
          })
        end,
        ["clangd"] = function()
          local capabilities = require("blink.cmp").get_lsp_capabilities()
          require("lspconfig").clangd.setup({
            capabilities = capabilities,
            on_attach = require("config.lspconfig").on_attach,
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=never",
            },
          })
        end,
        ["ts_ls"] = function()
          local vue_typescript_plugin = require("mason-registry")
              .get_package('vue-language-server')
              :get_install_path()
              .. '/node_modules/@vue/language-server'
              .. '/node_modules/@vue/typescript-plugin'

          require('lspconfig').ts_ls.setup({
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_typescript_plugin,
                  languages = { 'javascript', 'typescript', 'vue' }
                }
              }
            },
            filetypes = {
              'javascript',
              'javascriptreact',
              'javascript.jsx',
              'typescript',
              'typescriptreact',
              'typescript.tsx',
              'vue'
            }
          })
        end
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "Bilal2453/luvit-meta",
    lazy = true,
  },
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
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
      },
    },

    opts_extend = { "sources.default" },
  },
}
