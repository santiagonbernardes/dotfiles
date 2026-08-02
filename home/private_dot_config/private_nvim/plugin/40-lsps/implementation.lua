require('custom.helpers.lsp').on_attach(
  'textDocument/implementation',
  function(_, bufnr)
    vim.keymap.set(
      { 'n', 'v' },
      'gri',
      function() MiniExtra.pickers.lsp({ scope = 'implementation' }) end,
      { desc = 'go to [i]mplementation', buf = bufnr }
    )
  end
)
