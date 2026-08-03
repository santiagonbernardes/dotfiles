--- @type LspConfig
return {
  method = 'textDocument/linkedEditingRange',
  enable = function(client, _)
    vim.lsp.linked_editing_range.enable(true, {
      client_id = client.id,
    })
  end,
  keymaps = {
    {

      modes = { 'n', 'v' },
      lhs = '<leader>tle',
      rhs = function(client, _)
        return function()
          vim.lsp.linked_editing_range.enable(
            not vim.lsp.linked_editing_range.is_enabled(),
            {
              client_id = client.id,
            }
          )
        end
      end,
      opts = function(_, bufnr)
        return { desc = '[t]oggle [l]inked [e]diting range', buf = bufnr }
      end,
    },
  },
}
