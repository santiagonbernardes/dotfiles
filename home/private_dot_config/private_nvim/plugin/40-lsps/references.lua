require('custom.helpers.lsp').on_attach(
  'textDocument/references',
  function(_, bufnr)
    vim.keymap.set(
      { 'n', 'v' },
      'grr',
      function() MiniExtra.pickers.lsp({ scope = 'references' }) end,
      { desc = 'go to [r]references', buf = bufnr }
    )
  end
)
