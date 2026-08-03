--- @type LspConfig
return {
  method = 'workspace/diagnostic',
  enable = function(client, _)
    vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
  end,
  keymaps = {},
}
