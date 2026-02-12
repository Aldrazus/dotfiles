vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
require("nvim-autopairs").setup({})

vim.pack.add({ "https://github.com/tpope/vim-sleuth" })

vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })
require("todo-comments").setup({})

vim.pack.add({ "https://github.com/numToStr/Comment.nvim" })
require("Comment").setup({})

vim.pack.add({ "https://github.com/folke/flash.nvim" })
local Flash = require("flash")
Flash.setup({})

local map = vim.keymap.set
map({ "n", "x", "o" }, "s", function()
  Flash.jump()
end)
map({ "n", "x", "o" }, "S", function()
  Flash.treesitter()
end)
map("o", "r", function()
  Flash.remote()
end)
map({ "o", "x" }, "R", function()
  Flash.treesitter_search()
end)
map("c", "<c-s>", function()
  Flash.toggle()
end)

vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
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
})

vim.pack.add({ "https://github.com/andymass/vim-matchup" })
require("match-up").setup({
  treesitter = {
    stopline = 500,
  },
})
