--- TODO: Check if this causes any conflict with confirm
--- @type LspConfig
return {
  method = 'textDocument/onTypeFormatting',
  enable = function(client, _)
    vim.lsp.on_type_formatting.enable(true, {
      client_id = client.id,
    })
  end,
  keymaps = {},
}
