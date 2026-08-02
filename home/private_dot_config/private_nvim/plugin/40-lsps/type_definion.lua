require('custom.helpers.lsp').on_attach(
  'textDocument/typeDefinition',
  function(_, bufnr)
    vim.keymap.set(
      { 'n', 'v' },
      'grt',
      function() MiniExtra.pickers.lsp({ scope = 'type_definition' }) end,
      { desc = 'go to [t]ype definitions', buf = bufnr }
    )
  end
)
