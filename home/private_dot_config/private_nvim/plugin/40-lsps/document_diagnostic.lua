require('custom.helpers.lsp').on_attach(
  'textDocument/diagnostic',
  function(_, bufnr)
    vim.keymap.set(
      { 'n', 'v' },
      'grd',
      MiniExtra.pickers.diagnostics,
      { desc = 'go to [d]iagnostics', buf = bufnr }
    )
  end
)
