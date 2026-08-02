require('custom.helpers.lsp').on_attach(
  'textDocument/codeAction',
  function(_, bufnr)
    vim.keymap.set(
      { 'n', 'v' },
      'gra',
      function() vim.lsp.buf.code_action() end,
      { desc = 'show code [a]ctions', buf = bufnr }
    )
  end
)
