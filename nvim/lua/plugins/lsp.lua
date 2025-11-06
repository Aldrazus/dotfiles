return {
  { "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0
        }
      }
    }
  },
  {"nvim-java/nvim-java", ft = "java", opts = {}},
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        ensure_installed = { "clangd", "lua_ls", "vue_ls", "vtsls" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "blink.cmp",
    },
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
    event = "InsertEnter",
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
