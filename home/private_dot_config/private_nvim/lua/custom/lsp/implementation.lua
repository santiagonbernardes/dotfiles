--- @type LspConfig
return {
  method = 'textDocument/implementation',
  keymaps = {
    {
      modes = 'n',
      lhs = 'gri',
      rhs = function(_, _)
        return function() MiniExtra.pickers.lsp({ scope = 'implementation' }) end
      end,
      opts = function(_, bufnr)
        return { desc = 'go to [i]mplementation', buf = bufnr }
      end,
    },
  },
}
