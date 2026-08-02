require('custom.helpers.lsp').on_attach(
  'textDocument/definition',
  function(_, bufnr)
    vim.keymap.set(
      { 'n', 'v' },
      '<C-]>',
      function() MiniExtra.pickers.lsp({ scope = 'definition' }) end,
      { desc = 'go to definition', buf = bufnr }
    )
  end
)
