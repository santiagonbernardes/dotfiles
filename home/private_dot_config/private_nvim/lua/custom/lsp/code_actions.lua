---@type LspConfig
return {
  method = 'textDocument/codeAction',
  keymaps = {
    {
      modes = { 'n', 'v' },
      lhs = 'gra',
      rhs = function(_, _)
        return function() vim.lsp.buf.code_action() end
      end,
      opts = function(client, bufnr)
        return { desc = 'show code [a]ctions', buf = bufnr }
      end,
    },
  },
}
