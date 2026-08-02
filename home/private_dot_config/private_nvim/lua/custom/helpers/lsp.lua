local notify_helper = require('custom.helpers.notify')

local M = {}
--- Helper to handle client validation
--- @param method vim.lsp.protocol.Method.ClientToServer | vim.lsp.protocol.Method.Registration
--- @param config_function fun(client: vim.lsp.Client, bufnr?: integer)
M.on_attach = function(method, config_function)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup(
      ('lsp-on-attach-%s'):format(method),
      { clear = true }
    ),
    callback = function(event)
      local bufnr = event.data.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if not client then
        notify_helper.schedule_notify(
          ("Client probably not initiated. Can't configure LSP: [%s]"):format(
            method
          ),
          vim.log.levels.WARN
        )

        return
      end

      if not client:supports_method(method, bufnr) then
        notify_helper.schedule_notify(
          ('[%s] No support for: [%s]'):format(client.name, method),
          vim.log.levels.DEBUG
        )
        return
      end

      notify_helper.schedule_notify(
        ('[%s] Starting configuration of %s'):format(client.name, method),
        vim.log.levels.DEBUG
      )

      config_function(client, bufnr)

      notify_helper.schedule_notify(
        ('[%s] Finished configuration of %s'):format(client.name, method),
        vim.log.levels.DEBUG
      )
    end,
  })
end
return M
