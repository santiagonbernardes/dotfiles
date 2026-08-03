---@class Keymap
---@field modes string|string[]
---@field lhs string
---@field rhs fun(client: vim.lsp.Client, bufnr?: integer): function
---@field opts fun(client: vim.lsp.Client, bufnr?: integer): vim.keymap.set.Opts

--- @class LspConfig
--- @field keymaps Keymap[]
--- @field method vim.lsp.protocol.Method.ClientToServer | vim.lsp.protocol.Method.Registration
--- @field enable? fun(client: vim.lsp.Client, bufnr?: integer)

local modules_dir =
  vim.fs.joinpath(vim.fn.stdpath('config'), 'lua', 'custom', 'lsp')

local modules = vim
  .iter(vim.fs.dir(modules_dir, { follow = true }))
  :filter(
    function(file_name, type)
      return (type == 'file' or type == 'link')
        and file_name:match('%.lua$')
        and file_name ~= 'init.lua'
    end
  )
  :map(function(file_name, _)
    local module_name = file_name:gsub('%.lua$', '')
    local module = require('custom.lsp.' .. module_name)
    if vim.isarray(module) then return module end
    return { module }
  end)
  :totable()

--- @return LspConfig[]
return vim.iter(modules):flatten():totable()
