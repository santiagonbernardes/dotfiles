require('custom.helpers.lsp').on_attach(
  'textDocument/codeLens',
  function(client, bufnr)
    vim.lsp.codelens.enable(true, { client_id = client.id, bufnr = bufnr })

    vim.keymap.set(
      { 'n', 'v' },
      'grx',
      function() vim.lsp.codelens.run({ client_id = client.id }) end,
      { desc = 'e[x]ecute codelens', buf = bufnr }
    )

    vim.keymap.set(
      { 'n', 'v' },
      '<leader>tx',
      function() vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled()) end,
      { desc = 'toggle codelens', buf = bufnr }
    )
  end
)
