--- @type LspConfig
return {
  method = 'textDocument/completion',
  keymaps = {},
  enable = function(client, bufnr)
    client.server_capabilities.completionProvider.triggerCharacters = vim
      .iter(vim.fn.range(32, 126))
      :map(function(char_byte) return string.char(char_byte) end)
      :totable()

    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  end,
}
