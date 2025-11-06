return {
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua"
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    event = {"BufReadPre", "BufNewFile"},
  }
}
