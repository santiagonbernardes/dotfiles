require('custom.helpers.lsp').on_attach(
  'textDocument/inlayHint',
  function(_, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    vim.keymap.set(
      { 'n', 'v' },
      '<leader>tih',
      function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled(),
          { bufnr = bufnr }
        )
      end,
      { desc = '[t]oggle [i]nlay [h]ints', buf = bufnr }
    )
  end
)
