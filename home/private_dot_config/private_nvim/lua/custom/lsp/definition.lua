--- @type LspConfig
return {
  method = 'textDocument/definition',
  keymaps = {
    {
      modes = { 'n', 'v' },
      lhs = '<C-]>',
      rhs = function(_, _)
        return function() MiniExtra.pickers.lsp({ scope = 'definition' }) end
      end,
      opts = function(_, bufnr)
        return { desc = 'go to definition', buf = bufnr }
      end,
    },
  },
}
