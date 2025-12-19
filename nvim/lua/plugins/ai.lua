return {
  {
    "github/copilot.vim",
    config = function ()
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end
  },
  {
    "olimorris/codecompanion.nvim",
    version = "^18.0.0",
    opts = {},
    keys = {
      { "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = {"n", "v"}, noremap = true, silent = true},
      { "<Leader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = {"n", "v"}, noremap = true, silent = true},
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = {"v"}, noremap = true, silent = true}
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  }
}
