local leet_arg = "leetcode.nvim"

return {
  {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv(0, -1),
    cmd = "Leet",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      arg = leet_arg,
      picker = { provider = "snacks-picker" },
      plugins = {
        non_standalone = true,
      },
      lang = "cpp",
    },
  },
}
