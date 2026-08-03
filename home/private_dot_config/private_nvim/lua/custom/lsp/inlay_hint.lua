--- @type LspConfig
return {
  method = 'textDocument/inlayHint',
  enable = function(_, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
  keymaps = {
    {

      modes = { 'n', 'v' },
      lhs = '<leader>tih',
      rhs = function(_, bufnr)
        return function()
          vim.lsp.inlay_hint.enable(
            not vim.lsp.inlay_hint.is_enabled(),
            { bufnr = bufnr }
          )
        end
      end,
      opts = function(_, bufnr)
        return { desc = '[t]oggle [i]nlay [h]ints', buf = bufnr }
      end,
    },
  },
}
