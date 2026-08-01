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
    local buffer_id = event.data.buf
    local client = vim.lsp.get_client_by_id(client_id)

    if not client then
      -- TODO: Is this possible?
      notify_helper.schedule_notify(
        ('Failed to configure LSP for buffer_id %d. The LSP client might not be fully initialized yet'):format(
          buffer_id
        ),
        vim.log.levels.ERROR
      )

      return
    end

    local telescope = require('telescope.builtin')

    if client:supports_method('textDocument/codeLens', buffer_id) then
      -- OK
      vim.lsp.codelens.enable(true, { bufnr = buffer_id })
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

    if client:supports_method('textDocument/completion', buffer_id) then
      -- OK
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      client.server_capabilities.completionProvider.triggerCharacters = vim
        .iter(vim.fn.range(32, 126))
        :map(function(char_byte) return string.char(char_byte) end)
        :totable()

      vim.lsp.completion.enable(
        true,
        client.id,
        buffer_id,
        { autotrigger = true }
      )
    end

    if client:supports_method('textDocument/documentColor', buffer_id) then
      vim.lsp.document_color.enable(
        true,
        { client_id = client_id, bufnr = buffer_id }
      )
    end

    -- Inlay hints
    if client:supports_method('textDocument/inlayHint', buffer_id) then
      -- OK
      vim.lsp.inlay_hint.enable(true, { bufnr = buffer_id })
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
    if client:supports_method('textDocument/inlineCompletion', buffer_id) then
      -- OK
      vim.lsp.inline_completion.enable(true, { bufnr = buffer_id })
    end

    -- Linked editing (e.g. closing a html tag)
    if client:supports_method('textDocument/linkedEditingRange', buffer_id) then
      -- OK
      vim.lsp.linked_editing_range.enable(true, {
        client_id = client_id,
      })
    end

    -- On type formatting (have to consider conflicts with conform)
    if client:supports_method('textDocument/onTypeFormatting', buffer_id) then
      -- OK
      vim.lsp.on_type_formatting.enable(true, {
        client_id = client_id,
      })
    end

    if client:supports_method('textDocument/semanticTokens', buffer_id) then
      -- OK, have to understand what it is :D
      vim.lsp.semantic_tokens.enable(
        true,
        { bufnr = buffer_id, client_id = client_id }
      )
    end

    if client:supports_method('workspace/diagnostic', buffer_id) then
      vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
    end

    if client:supports_method('textDocument/codeAction', buffer_id) then
      vim.keymap.set(
        { 'n', 'v' },
        'gra',
        function() require('actions-preview').code_actions() end,
        { desc = 'show code [a]ctions' }
      )
    end

    if client:supports_method('textDocument/implementation', buffer_id) then
      vim.keymap.set(
        { 'n', 'v' },
        'gri',
        telescope.lsp_implementations,
        { desc = 'go to [i]mplementations' }
      )
    end

    if client:supports_method('textDocument/references', buffer_id) then
      vim.keymap.set(
        { 'n', 'v' },
        'grr',
        telescope.lsp_references,
        { desc = 'go to [r]references' }
      )
    end

    if client:supports_method('textDocument/typeDefinition', buffer_id) then
      vim.keymap.set(
        { 'n', 'v' },
        'grt',
        telescope.lsp_type_definitions,
        { desc = 'go to [t]ype definitions' }
      )
    end

    if client:supports_method('textDocument/documentSymbol', buffer_id) then
      vim.keymap.set(
        { 'n', 'v' },
        'gO',
        telescope.lsp_document_symbols,
        { desc = 'go to d[O]cument symbols' }
      )
    end

    if client:supports_method('workspace/symbol', buffer_id) then
      vim.keymap.set(
        { 'n', 'v' },
        'gW',
        telescope.lsp_document_symbols,
        { desc = 'go to [W]orkspace symbols' }
      )
    end

    if client:supports_method('textDocument/diagnostic', buffer_id) then
      vim.keymap.set(
        { 'n', 'v' },
        'grd',
        telescope.diagnostics,
        { desc = 'go to [d]iagnostics' }
      )
    end

    if client:supports_method('textDocument/rename', buffer_id) then
      vim.keymap.set(
        { 'n', 'v' },
        'grn',
        telescope.diagnostics,
        { desc = '[r]ename under the cursor' }
      )
    end
  end,
})
