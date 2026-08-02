require('custom.helpers.lsp').on_attach(
  'textDocument/onTypeFormatting',
  function(client, _)
    -- OK
    vim.lsp.on_type_formatting.enable(true, {
      client_id = client.id,
    })
  end
)
