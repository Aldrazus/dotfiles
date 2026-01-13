return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    version = "^1.11.0",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd([[colorscheme catppuccin]])
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      require("config.lualine")
    end,
  },
}
