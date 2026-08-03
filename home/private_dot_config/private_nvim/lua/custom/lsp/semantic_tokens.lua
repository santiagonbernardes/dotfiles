-- TODO: have to understand what it is :D
--- @type LspConfig
return {
  method = 'textDocument/semanticTokens',
  enable = function(client, bufnr)
    vim.lsp.semantic_tokens.enable(
      true,
      { bufnr = bufnr, client_id = client.id }
    )
  end,
  keymaps = {
    {
      modes = 'n',
      lhs = '<leader>tlk',
      rhs = function(client, bufnr)
        return function()
          vim.lsp.semantic_tokens.enable(
            vim.lsp.semantic_tokens.is_enabled({
              bufnr = bufnr,
              client_id = client.id,
            }),
            { bufnr = bufnr, client_id = client.id }
          )
        end
      end,
      opts = function(_, bufnr)
        return {
          desc = '[t]oggle semantic to[k]ens',
          buf = bufnr,
        }
      end,
    },
  },
}
