-- Inline completion (like Copilot)
require('custom.helpers.lsp').on_attach(
  'textDocument/inlineCompletion',
  function(client, bufnr)
    vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

    vim.keymap.set(
      { 'n', 'v' },
      '<leader>tic',
      function()
        vim.lsp.inline_completion.enable(
          not vim.lsp.inline_completion.is_enabled(),
          { bufnr = bufnr }
        )
      end,
      { desc = '[t]oggle [i]nline [c]ompletion', buf = bufnr }
    )
  end
)
