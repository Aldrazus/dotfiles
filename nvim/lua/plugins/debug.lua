return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for nvim-dap
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",

      -- Virtual text for nvim-dap
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end,                                             desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval() end,                                               desc = "Eval",                  mode = { "n", "v" } },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup dap-ui
      dapui.setup()

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup()

      -- Automatically open/close dapui
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Configure adapters for your languages here
      -- Example for Node.js:
      -- dap.adapters.node2 = {
      --   type = "executable",
      --   command = "node",
      --   args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      -- }
    end,
  },
}
