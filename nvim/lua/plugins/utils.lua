return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  { "tpope/vim-sleuth", event = { "BufReadPost", "BufNewFile" } },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" } },
      { "gb", mode = { "n", "v" } },
    },
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          enabled = true,
          jump_labels = true,
        },
      },
    },
    keys = {
      { "s", function() require("flash").jump() end, mode = { "n", "x", "o" } },
      { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" } },
      { "r", function() require("flash").remote() end, mode = "o" },
      { "R", function() require("flash").treesitter_search() end, mode = { "o", "x" } },
      { "<c-s>", function() require("flash").toggle() end, mode = "c" },
    },
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },
  { "andymass/vim-matchup", event = { "BufReadPost", "BufNewFile" } },
  { "tpope/vim-surround", event = { "BufReadPost", "BufNewFile" } },
}
