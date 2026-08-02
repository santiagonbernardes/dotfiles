require('custom.helpers.lsp').on_attach(
  'textDocument/documentColor',
  function(client, bufnr)
    vim.lsp.document_color.enable(
      true,
      { client_id = client.id, bufnr = bufnr }
    )

    vim.keymap.set(
      { 'n', 'v' },
      '<leader>tdc',
      function()
        vim.lsp.document_color.enable(
          not vim.lsp.document_color.is_enabled(),
          { client_id = client.id, bufnr = bufnr }
        )
      end,
      { desc = '[t]oggle [d]ocument [c]olor' }
    )
  end
)
