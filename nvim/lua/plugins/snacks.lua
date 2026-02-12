vim.pack.add({
  "https://github.com/folke/snacks.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

local Snacks = require("snacks")
Snacks.setup({
  indent = {},
  picker = {},
  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      { section = "keys", gap = 1 },
      { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
      { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
    },
  },
})

local map = vim.keymap.set

-- Search
map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find Files" })
map("n", "<leader>fg", function()
  Snacks.picker.grep()
end, { desc = "Live Grep" })
map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Find Buffers" })
map("n", "<leader>st", function()
  Snacks.picker.todo_comments()
end, { desc = "Find TODO comments" })

-- LSP
map("n", "gD", function()
  Snacks.picker.lsp_declarations()
end, { desc = "Go to declaration" })
map("n", "gd", function()
  Snacks.picker.lsp_definitions()
end, { desc = "Go to definition" })
map("n", "gr", function()
  Snacks.picker.lsp_references()
end, { desc = "Go to references" })
map("n", "gi", function()
  Snacks.picker.lsp_implementation()
end, { desc = "Go to implementation" })
map("n", "gy", function()
  Snacks.picker.lsp_type_definitions()
end, { desc = "Go to type definition" })
map("n", "<leader>ds", function()
  Snacks.picker.lsp_symbols()
end, { desc = "[d]ocument [s]ymbols" })
map("n", "<leader>ws", function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = "[w]orkspace [s]ymbols" })
