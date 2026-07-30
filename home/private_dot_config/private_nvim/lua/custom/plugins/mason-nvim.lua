---@type Plugin
return {
  spec = {
    src = 'https://github.com/mason-org/mason.nvim',
    version = vim.version.range('2'),
  },
  configure = function() require('mason').setup() end,
}
