require('custom.helpers.lsp').on_attach(
  'textDocument/linkedEditingRange',
  function(client, bufnr)
    vim.lsp.linked_editing_range.enable(true, {
      client_id = client.id,
    })

    vim.keymap.set(
      { 'n', 'v' },
      '<leader>tle',
      function()
        vim.lsp.linked_editing_range.enable(
          not vim.lsp.linked_editing_range.is_enabled(),
          {
            client_id = client.id,
          }
        )
      end,
      { desc = '[t]oggle [l]inked [e]diting range', buf = bufnr }
    )
  end
)
