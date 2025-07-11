-- Sourced from: https://github.com/vuejs/language-tools/wiki/Neovim

local vue_language_server_path = vim.fn.expand(
    '$MASON/packages/vue-language-server'
    .. '/node_modules/@vue/language-server'
)

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

return vtsls_config
