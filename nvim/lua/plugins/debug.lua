vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })
vim.pack.add({ "https://github.com/rcarriga/nvim-dap-ui" })
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio" })
vim.pack.add({ "https://github.com/theHamsta/nvim-dap-virtual-text" })

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
require("nvim-dap-virtual-text").setup()

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

local map = vim.keymap.set
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional Breakpoint" })
map("n", "<leader>dc", function() dap.continue() end, { desc = "Continue" })
map("n", "<leader>dC", function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
map("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
map("n", "<leader>do", function() dap.step_over() end, { desc = "Step Over" })
map("n", "<leader>dO", function() dap.step_out() end, { desc = "Step Out" })
map("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
map("n", "<leader>dl", function() dap.run_last() end, { desc = "Run Last" })
map("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate" })
map("n", "<leader>du", function() dapui.toggle() end, { desc = "Toggle DAP UI" })
map({ "n", "v" }, "<leader>de", function() dapui.eval() end, { desc = "Eval" })
