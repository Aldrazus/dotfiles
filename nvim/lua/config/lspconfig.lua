local map = vim.keymap.set

local M = {}

M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc}
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gr", vim.lsp.buf.references, opts "Go to references")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "K", vim.lsp.buf.hover, opts "Hover Documentation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Type [D]efinition")
  map("n", "<leader>rn", vim.lsp.buf.rename, opts "[r]e[n]ame")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "[c]ode [a]ction")
  map("n", "<leader>ds", vim.lsp.buf.document_symbol, opts "[d]ocument [s]ymbols")
  map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts "[w]orkspace [s]ymbols")

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  -- C++ stuff
  map("n", "<leader>cs", ":ClangdSwitchSourceHeader<CR>", opts "[C]langd [S]witch Source Header")


  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

return M
