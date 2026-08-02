require('custom.helpers.lsp').on_attach(
  'workspace/diagnostic',
  function(client, _)
    vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
  end
)
