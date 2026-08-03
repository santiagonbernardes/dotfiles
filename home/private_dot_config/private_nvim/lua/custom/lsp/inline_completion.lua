-- Inline completion (like Copilot)
--- @type LspConfig
return {
  method = 'textDocument/inlineCompletion',
  enable = function(client, bufnr)
    vim.lsp.inline_completion.enable(
      true,
      { bufnr = bufnr, client_id = client.id }
    )
  end,
  keymaps = {
    {

      modes = { 'n', 'v' },
      lhs = '<leader>tic',
      rhs = function(client, bufnr)
        return function()
          vim.lsp.inline_completion.enable(
            not vim.lsp.inline_completion.is_enabled(),
            { bufnr = bufnr, client_id = client.id }
          )
        end
      end,
      opts = function(_, bufnr)
        return { desc = '[t]oggle [i]nline [c]ompletion', buf = bufnr }
      end,
    },
  },
}
