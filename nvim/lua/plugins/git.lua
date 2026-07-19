return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        view = {
          merge_tool = {
            layout = "diff3_mixed",
          },
        },
        keymaps = {
          view = {
            { "n", "<leader>mo", actions.conflict_choose("ours"), { desc = "Merge: choose OURS" } },
            { "n", "<leader>mt", actions.conflict_choose("theirs"), { desc = "Merge: choose THEIRS" } },
            { "n", "<leader>mb", actions.conflict_choose("base"), { desc = "Merge: choose BASE" } },
            { "n", "<leader>ma", actions.conflict_choose("all"), { desc = "Merge: choose ALL" } },
            { "n", "<leader>mx", actions.conflict_choose("none"), { desc = "Merge: delete conflict" } },
          },
        },
      })
    end,
  },
}
