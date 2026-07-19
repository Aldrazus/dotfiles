return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      indent = {},
      picker = {
        sources = {
          lsp_symbols = {
            filter = {
              default = {
                "Class",
                "Constructor",
                "Enum",
                "Field",
                "Function",
                "Interface",
                "Method",
                "Module",
                "Namespace",
                "Package",
                "Property",
                "Struct",
                "Trait",
                "Variable",
              },
            },
          },
        },
      },
    },
    keys = {
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live Grep" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Find TODO comments" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Go to declaration" },
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Go to definition" },
      { "gr", function() Snacks.picker.lsp_references() end, desc = "Go to references" },
      { "gi", function() Snacks.picker.lsp_implementation() end, desc = "Go to implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Go to type definition" },
      { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "[d]ocument [s]ymbols" },
      { "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, desc = "[w]orkspace [s]ymbols" },
    },
  },
}
