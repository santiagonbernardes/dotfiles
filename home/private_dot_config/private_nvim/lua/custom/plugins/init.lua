local file_helper = require('custom.helpers.file')
local M = {}

---@class Plugin
---@field spec vim.pack.Spec
---@field dependencies? Plugin[]
---@field optional? Plugin[]
---@field configure? fun()

---@return Plugin[]
local function get_plugins()
  local plugins_dir =
    vim.fs.joinpath(vim.fn.stdpath('config'), 'lua', 'custom', 'plugins')

  return vim
    .iter(file_helper.get_modules_file_names(plugins_dir))
    :map(function(file_name)
      local module_name = file_name:gsub('%.lua$', '')
      return require(('custom.plugins.%s'):format(module_name))
    end)
    :totable()
end

---@return vim.pack.Spec[]
M.get_specs = function()
  return vim
    .iter(get_plugins())
    :map(
      function(plugin)
        return {
          plugin,
          unpack(plugin.dependencies or {}),
          unpack(plugin.optional or {}),
        }
      end
    )
    :flatten()
    :map(function(plugin) return plugin.spec end)
    :unique(function(spec) return spec.src end)
    :totable()
end

M.configure = function()
  for _, plugin in ipairs(get_plugins()) do
    if plugin.configure then plugin.configure() end
  end
end

return M
