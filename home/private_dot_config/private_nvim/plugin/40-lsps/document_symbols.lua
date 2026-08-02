require('custom.helpers.lsp').on_attach(
  'textDocument/documentSymbol',
  function(_, bufnr)
    vim.keymap.set(
      { 'n', 'v' },
      'gO',
      function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end,
      { desc = '[g]o to d[O]cument symbols', buf = bufnr }
    )
  end
)
