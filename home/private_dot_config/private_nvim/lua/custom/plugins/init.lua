local M = {}

---@class Plugin
---@field spec vim.pack.Spec
---@field dependencies? Plugin[]
---@field optional? Plugin[]
---@field configure? fun()

---@param filename string
---@param type string
---@return boolean
local function is_plugin(filename, type)
  return (type == 'file' or type == 'link')
    and filename:match('%.lua$')
    and filename ~= 'init.lua'
end

---@return Plugin[]
local function get_plugins()
  local plugins = {}

  local plugins_dir =
    vim.fs.joinpath(vim.fn.stdpath('config'), 'lua', 'custom', 'plugins')

  for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
    if is_plugin(file_name, type) then
      local module = file_name:gsub('%.lua$', '')
      table.insert(plugins, require('custom.plugins.' .. module))
    end
  end

  return plugins
end

---@return vim.pack.Spec[]
M.get_specs = function()
  local specs = {}
  local added = {}

  ---@param plugin Plugin
  local add_if_absent = function(plugin)
    local spec = plugin.spec
    local src = spec.src
    if not added[src] then
      table.insert(specs, spec)
      added[src] = true
    end
  end

  for _, plugin in ipairs(get_plugins()) do
    if not added[plugin.spec.src] then add_if_absent(plugin) end

    for _, dependency_plugin in ipairs(plugin.dependencies or {}) do
      add_if_absent(dependency_plugin)
    end

    for _, optional_plugin in ipairs(plugin.optional or {}) do
      add_if_absent(optional_plugin)
    end
  end

  return specs
end

M.configure = function()
  for _, plugin in ipairs(get_plugins()) do
    if plugin.configure then
      plugin.configure()
    end
  end
end

return M
