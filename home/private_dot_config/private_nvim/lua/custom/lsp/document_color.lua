--- @type LspConfig
return {
  method = 'textDocument/documentColor',
  enable = function(client, bufnr)
    vim.lsp.document_color.enable(
      true,
      { client_id = client.id, bufnr = bufnr }
    )
  end,
  keymaps = {
    {
      modes = { 'n', 'v' },
      lhs = '<leader>tdc',
      rhs = function(client, bufnr)
        return function()
          vim.lsp.document_color.enable(
            not vim.lsp.document_color.is_enabled(),
            { client_id = client.id, bufnr = bufnr }
          )
        end
      end,
      opts = function(_, bufnr)
        return { desc = '[t]oggle [d]ocument [c]olor', buf = bufnr }
      end,
    },
  },
}
