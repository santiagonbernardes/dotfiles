local M = {}

---@param file_name string
---@param type string
---@return boolean
local function is_module(file_name, type)
  if not vim.tbl_contains({ 'file', 'link' }, type) then return false end

  if not file_name:match('%.lua$') then return false end

  return file_name ~= 'init.lua' and file_name:sub(1, 1) ~= '_'
end

---Return all the modules in a directory based on the options
---@param directory_path string
---@return string[]
M.get_modules_file_names = function(directory_path)
  local stat = vim.uv.fs_stat(directory_path)
  if not stat then
    vim.notify(
      ('Failed to get modules file names from directory %'):format(
        directory_path
      ),
      vim.log.levels.ERROR
    )
    return {}
  end

  if not stat.type == 'directory' then
    vim.notify(
      ('Failed to get modules file names. The path % does not point to a directory'):format(
        directory_path
      ),
      vim.log.levels.ERROR
    )
    return {}
  end

  return vim
    .iter(vim.fs.dir(directory_path, { follow = true }))
    :filter(function(file_name, type) return is_module(file_name, type) end)
    :map(function(file_name, _) return file_name end)
    :totable()
end

return M
