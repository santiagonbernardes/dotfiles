local M = {}
--- Adds an autocomand when a plugin is installed or updated
---@param plugin_name string
---@param action_fun fun(event: vim.api.keyset.create_autocmd.callback_args)
---@param group integer?
M.add_on_change_upinstall_autocmd = function(plugin_name, action_fun, group)
  group = group
    or vim.api.nvim_create_augroup(
      plugin_name .. '-upinstall',
      { clear = true }
    )
  vim.api.nvim_create_autocmd('PackChanged', {
    desc = 'Run an action when ' .. plugin_name .. 'is installed or updated.',
    group = group,
    callback = function(event)
      local name = event.data.spec.name
      local kind = event.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end
      if name ~= plugin_name then return end

      action_fun(event)
    end,
  })
end

---Executes a system command, handling its errors
---@param caller string
---@param command string[]
---@param working_directory string
M.run_system_command = function(caller, command, working_directory)
  vim.system(command, { cwd = working_directory }, function(result)
    if result.code == 0 then return end

    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then output = 'No output from system command.' end
    vim.notify(
      ('Failed to run the system command "%s" for caller %s:\n%s'):format(
        table.concat(command, ' '),
        caller,
        output
      ),
      vim.log.levels.ERROR
    )
  end)
end

return M
