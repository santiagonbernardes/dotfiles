--- @type LspConfig
return {
  method = 'textDocument/typeDefinition',
  keymaps = {
    {
      modes = 'n',
      lhs = 'grt',
      rhs = function(_, _)
        return function() MiniExtra.pickers.lsp({ scope = 'type_definition' }) end
      end,
      opts = function(_, bufnr)
        return { desc = 'go to [t]ype definitions', buf = bufnr }
      end,
    },
  },
}
