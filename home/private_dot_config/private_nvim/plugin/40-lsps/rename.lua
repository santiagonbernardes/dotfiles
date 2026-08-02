require('custom.helpers.lsp').on_attach(
  'textDocument/rename',
  function(_, bufnr)
    vim.keymap.set(
      { 'n', 'v' },
      'grn',
      vim.lsp.buf.rename,
      { desc = 're[n]ame under the cursor', buf = bufnr }
    )
  end
)
