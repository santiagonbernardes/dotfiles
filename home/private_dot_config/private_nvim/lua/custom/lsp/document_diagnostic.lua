--- @type LspConfig
return {
  method = 'textDocument/diagnostic',
  keymaps = {
    {
      modes = { 'n', 'v' },
      lhs = 'grd',
      rhs = function(_, _) return MiniExtra.pickers.diagnostic end,
      opts = function(_, bufnr)
        return { desc = 'go to [d]iagnostic', buf = bufnr }
      end,
    },
  },
}
