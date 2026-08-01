local notify_helper = require('custom.helpers.notify')

vim.lsp.enable({
  'lua_ls',
  'pyright',
  'ruff',
  'ansible-language-server',
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-on-attach-config', { clear = true }),
  callback = function(event)
    local client_id = event.data.client_id
    local buffnr = event.data.buf
    local client = vim.lsp.get_client_by_id(client_id)

    if not client then
      -- TODO: Is this possible?
      notify_helper.schedule_notify(
        ('Failed to configure LSP for buffer_id %d. The LSP client might not be fully initialized yet'):format(
          buffnr
        ),
        vim.log.levels.ERROR
      )

      return
    end

    if client:supports_method('textDocument/codeLens', buffnr) then
      -- OK
      vim.lsp.codelens.enable(true, { bufnr = buffnr })
      vim.keymap.set(
        { 'n', 'v' },
        'grx',
        function() vim.lsp.codelens.run({ client_id = client.id }) end,
        { desc = 'e[x]ecute codelens' }
      )

      vim.keymap.set(
        { 'n', 'v' },
        '<leader>tx',
        function() vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled()) end,
        { desc = 'toggle codelens' }
      )
    end

    if client:supports_method('textDocument/completion', buffnr) then
      -- OK
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      client.server_capabilities.completionProvider.triggerCharacters = vim
        .iter(vim.fn.range(32, 126))
        :map(function(char_byte) return string.char(char_byte) end)
        :totable()

      vim.lsp.completion.enable(true, client.id, buffnr, { autotrigger = true })
    end

    if client:supports_method('textDocument/documentColor', buffnr) then
      vim.lsp.document_color.enable(
        true,
        { client_id = client_id, bufnr = buffnr }
      )
    end

    -- Inlay hints
    if client:supports_method('textDocument/inlayHint', buffnr) then
      -- OK
      vim.lsp.inlay_hint.enable(true, { bufnr = buffnr })
      vim.keymap.set(
        { 'n', 'v' },
        '<leader>tlh',
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end,
        { desc = 'toggle inlay [h]ints' }
      )
    end

    -- Inline completion (like Copilot)
    if client:supports_method('textDocument/inlineCompletion', buffnr) then
      -- OK
      vim.lsp.inline_completion.enable(true, { bufnr = buffnr })
    end

    -- Linked editing (e.g. closing a html tag)
    if client:supports_method('textDocument/linkedEditingRange', buffnr) then
      -- OK
      vim.lsp.linked_editing_range.enable(true, {
        client_id = client_id,
      })
    end

    -- On type formatting (have to consider conflicts with conform)
    if client:supports_method('textDocument/onTypeFormatting', buffnr) then
      -- OK
      vim.lsp.on_type_formatting.enable(true, {
        client_id = client_id,
      })
    end

    if client:supports_method('textDocument/semanticTokens', buffnr) then
      -- OK, have to understand what it is :D
      vim.lsp.semantic_tokens.enable(
        true,
        { bufnr = buffnr, client_id = client_id }
      )
    end

    if client:supports_method('workspace/diagnostic', buffnr) then
      vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
    end

    if client:supports_method('textDocument/codeAction', buffnr) then
      vim.keymap.set(
        { 'n', 'v' },
        'gra',
        function() vim.lsp.buf.code_action() end,
        { desc = 'show code [a]ctions' }
      )
    end

    if client:supports_method('textDocument/implementation', buffnr) then
      vim.keymap.set(
        { 'n', 'v' },
        'gri',
        function() MiniExtra.pickers.lsp({ scope = 'implementation' }) end,
        { desc = 'go to [i]mplementations' }
      )
    end

    if client:supports_method('textDocument/references', buffnr) then
      vim.keymap.set(
        { 'n', 'v' },
        'grr',
        function() MiniExtra.pickers.lsp({ scope = 'references' }) end,
        { desc = 'go to [r]references' }
      )
    end

    if client:supports_method('textDocument/definition', buffnr) then
      vim.keymap.set(
        { 'n', 'v' },
        '<C-]>',
        function() MiniExtra.pickers.lsp({ scope = 'definition' }) end,
        { desc = 'go to definition' }
      )
    end

    if client:supports_method('textDocument/typeDefinition', buffnr) then
      vim.keymap.set(
        { 'n', 'v' },
        'grt',
        function() MiniExtra.pickers.lsp({ scope = 'type_definition' }) end,
        { desc = 'go to [t]ype definitions' }
      )
    end

    if client:supports_method('textDocument/documentSymbol', buffnr) then
      vim.keymap.set(
        { 'n', 'v' },
        'gO',
        function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end,
        { desc = 'go to d[O]cument symbols' }
      )
    end

    if client:supports_method('workspace/symbol', buffnr) then
      vim.keymap.set(
        { 'n', 'v' },
        'gW',
        function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol' }) end,
        { desc = 'go to [W]orkspace symbols' }
      )
    end

    if client:supports_method('textDocument/diagnostic', buffnr) then
      vim.keymap.set(
        { 'n', 'v' },
        'grd',
        MiniExtra.pickers.diagnostics,
        { desc = 'go to [d]iagnostics' }
      )
    end

    if client:supports_method('textDocument/rename', buffnr) then
      vim.keymap.set(
        { 'n', 'v' },
        'grn',
        vim.lsp.buf.rename,
        { desc = '[r]ename under the cursor' }
      )
    end
  end,
})
