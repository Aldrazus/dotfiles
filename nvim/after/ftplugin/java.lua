local jdtls = require("jdtls")
local jdtls_dap = require("jdtls.dap")

local root_dir = vim.fs.dirname(
  vim.fs.find({ "pom.xml", "build.gradle", "build.gradle.kts", ".git" }, { upward = true })[1]
) or vim.fn.getcwd()

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspaces/" .. project_name

-- Collect DAP bundles (requires java-debug-adapter and java-test from Mason)
local bundles = {}

local debug_jar = vim.fn.glob(
  vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
)
if debug_jar ~= "" then
  table.insert(bundles, debug_jar)
end

local test_jars = vim.fn.glob(
  vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar",
  false,
  true
)
vim.list_extend(bundles, test_jars)

local config = {
  cmd = { "jdtls", "-data", workspace_dir },
  root_dir = root_dir,
  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
    },
    signatureHelp = { enabled = true },
  },
  init_options = {
    bundles = bundles,
  },
  on_attach = function()
    jdtls.setup_dap({ hotcodereplace = "auto" })
    jdtls_dap.setup_dap_main_class_configs()
  end,
}

jdtls.start_or_attach(config)

local map = vim.keymap.set
local opts = { buffer = true }

map("n", "<leader>co", jdtls.organize_imports,  vim.tbl_extend("force", opts, { desc = "Organize imports" }))
map("n", "<leader>cv", jdtls.extract_variable,  vim.tbl_extend("force", opts, { desc = "Extract variable" }))
map("n", "<leader>cc", jdtls.extract_constant,  vim.tbl_extend("force", opts, { desc = "Extract constant" }))
map("v", "<leader>cm", jdtls.extract_method,    vim.tbl_extend("force", opts, { desc = "Extract method" }))
map("n", "<leader>jt", jdtls_dap.test_nearest_method, vim.tbl_extend("force", opts, { desc = "Test nearest method" }))
map("n", "<leader>jT", jdtls_dap.test_class,    vim.tbl_extend("force", opts, { desc = "Test class" }))
