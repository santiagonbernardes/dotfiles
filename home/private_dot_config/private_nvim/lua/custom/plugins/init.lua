local M = {}

---@class Plugin
---@field spec vim.pack.Spec
---@field dependencies? Plugin[]
---@field optional? Plugin[]
---@field configure? fun()

---@param file_name string
---@param type string
---@return boolean
local function is_plugin(file_name, type)
  if not vim.tbl_contains({ 'file', 'link' }, type) then return false end

  if file_name:match('%.lua$') then
    return file_name:sub(1, 1) ~= '_' and file_name ~= 'init.lua'
  end

  return false
end

---@return Plugin[]
local function get_plugins()
  local plugins_dir =
    vim.fs.joinpath(vim.fn.stdpath('config'), 'lua', 'custom', 'plugins')

  return vim
    .iter(vim.fs.dir(plugins_dir, { follow = true }))
    :filter(function(file_name, type) return is_plugin(file_name, type) end)
    :map(
      function(file_name, _)
        return require('custom.plugins.' .. file_name:gsub('%.lua$', ''))
      end
    )
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
