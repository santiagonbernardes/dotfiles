--- @type LspConfig[]
return {
  {
    method = 'textDocument/codeLens',
    keymaps = {
      modes = { 'n', 'v' },
      lhs = '<leader>tx',
      rhs = function(client, bufnr)
        return function()
          vim.lsp.codelens.enable(
            not vim.lsp.codelens.is_enabled(),
            { client_id = client.id, bufnr = bufnr }
          )
        end
      end,
      opts = function(_, bufnr)
        return { desc = 'toggle codelens', buf = bufnr }
      end,
    },
    enable = function(client, bufnr)
      vim.lsp.codelens.enable(true, { client_id = client.id, bufnr = bufnr })
    end,
  },
  {
    method = 'codeLens/resolve',
    keymaps = {
      {
        modes = 'n',
        lhs = 'grx',
        rhs = function(client, _)
          return function() vim.lsp.codelens.run({ client_id = client.id }) end
        end,
        opts = function(client, bufnr)
          return { desc = 'e[x]ecute codelens', buf = bufnr }
        end,
      },
    },
  },
}
