require('custom.helpers.lsp').on_attach(
  'textDocument/diagnostic',
  function(_, bufnr)
    vim.keymap.set(
      { 'n', 'v' },
      'grd',
      MiniExtra.pickers.diagnostic,
      { desc = 'go to [d]iagnostic', buf = bufnr }
    )
  end
)
