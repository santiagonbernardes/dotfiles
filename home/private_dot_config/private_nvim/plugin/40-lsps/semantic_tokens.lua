require('custom.helpers.lsp').on_attach(
  'textDocument/semanticTokens',
  function(client, bufnr)
    -- NOTE: have to understand what it is :D
    vim.lsp.semantic_tokens.enable(
      true,
      { bufnr = bufnr, client_id = client.id }
    )
  end
)
