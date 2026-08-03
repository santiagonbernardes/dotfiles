--- @type LspConfig
return {
  method = 'textDocument/documentSymbol',
  keymaps = {
    modes = 'n',
    lhs = 'gO',
    rhs = function(_, _)
      return function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end
    end,
    opts = function(_, bufnr)
      return { desc = '[g]o to d[O]cument symbols', buf = bufnr }
    end,
  },
}
