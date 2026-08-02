require('custom.helpers.lsp').on_attach('workspace/symbol', function(_, bufnr)
  vim.keymap.set(
    { 'n', 'v' },
    'gW',
    function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol' }) end,
    { desc = 'go to [W]orkspace symbols', buf = bufnr }
  )
end)
