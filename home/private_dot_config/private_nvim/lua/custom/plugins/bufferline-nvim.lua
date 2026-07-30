---@type Plugin
return {
  spec = {
    src = 'https://github.com/akinsho/bufferline.nvim',
    version = vim.version.range('4'),
  },
  dependencies = {
    require('custom.plugins.nvim-web-devicons'),
  },
  configure = function() require('bufferline').setup() end,
}
