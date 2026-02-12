vim.pack.add({ "https://github.com/github/copilot.vim" })
vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

vim.pack.add({ "https://github.com/ravitemer/mcphub.nvim" })
require("mcphub").setup({})

vim.pack.add({ "https://github.com/ravitemer/codecompanion-history.nvim" })

vim.pack.add({ "https://github.com/olimorris/codecompanion.nvim" })
require("codecompanion").setup({
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        -- MCP Tools
        make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
        show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
        add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
        show_result_in_chat = true, -- Show tool results directly in chat buffer
        format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
        -- MCP Resources
        make_vars = true, -- Convert MCP resources to #variables for prompts
        -- MCP Prompts
        make_slash_commands = true, -- Add MCP prompts as /slash commands
      },
    },
    history = {
      enabled = true,
      opts = {
        auto_generate_title = false,
        chat_filter = function(chat_data)
          return chat_data.cwd == vim.fn.getcwd()
        end,
      },
    },
  },
  adapters = {
    acp = {
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {
          env = {
            ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
          },
        })
      end,
    },
  },
  display = {
    action_palette = {
      provider = "default",
    },
  },
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
