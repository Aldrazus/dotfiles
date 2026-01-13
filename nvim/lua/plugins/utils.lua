return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    opts = { signs = false },
  },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {},
    event = { "BufReadPost", "BufNewFile" }
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {}, event = { "BufReadPost", "BufNewFile" } },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>",                 desc = "Find Files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>",             desc = "Live Grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",               desc = "Buffers" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>",             desc = "Help Tags" },
      { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>",  desc = "Document Symbols" },
      { "<leader>fS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
    },
    opts = {
      files = {
        formatter = "path.filename_first"
      },
      winopts = {
        width = 0.60,
        height = 0.20,
        preview = {
          hidden = true
        },
        border = "rounded"
      }
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = function()
      return require("config.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "Badhi/nvim-treesitter-cpp-tools",
    ft = { "cpp" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- Optional: Configuration
    opts = function()
      local options = {
        preview = {
          quit = "q",                             -- optional keymapping for quit preview
          accept = "<tab>",                       -- optional keymapping for accept preview
        },
        header_extension = "h",                   -- optional
        source_extension = "cpp",                 -- optional
        custom_define_class_function_commands = { -- optional
          TSCppImplWrite = {
            output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
          },
          --[[
                <your impl function custom command name> = {
                    output_handle = function (str, context)
                        -- string contains the class implementation
                        -- do whatever you want to do with it
                    end
                }
                ]]
        },
      }
      return options
    end,
    -- End configuration
    config = true,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    }
    ,
  },

  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
  },

  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },

  -- Used by other plugins
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "gennaro-tedesco/nvim-possession",
    event = "BufReadPre",
    dependencies = {
      "ibhagwan/fzf-lua",
    },
    opts = {},
    keys = {
      { "<leader>sl", function() require("nvim-possession").list() end, desc = "📌list sessions", },
      { "<leader>sn", function() require("nvim-possession").new() end, desc = "📌create new session", },
      { "<leader>su", function() require("nvim-possession").update() end, desc = "📌update current session", },
      { "<leader>sd", function() require("nvim-possession").delete() end, desc = "📌delete selected session" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      log_level = vim.log.levels.DEBUG,
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
}
