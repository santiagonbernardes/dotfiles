--- @type LspConfig
return {
  method = 'workspace/symbol',
  keymaps = {
    {
      modes = 'n',
      lhs = 'gW',
      rhs = function(_, _)
        return function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol' }) end
      end,
      opts = function(_, bufnr)
        return { desc = 'go to [W]orkspace symbols', buf = bufnr }
      end,
    },
  },
}
