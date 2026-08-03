--- @type LspConfig
return {
  method = 'textDocument/rename',
  keymaps = {
    {

      modes = 'n',
      lhs = 'grn',
      rhs = function(_, _) return vim.lsp.buf.rename end,
      opts = function(_, bufnr)
        return { desc = 're[n]ame under the cursor', buf = bufnr }
      end,
    },
  },
}
