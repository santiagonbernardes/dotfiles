---@type Plugin
return {
  spec = {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3'),
  },
  dependencies = {
    require('custom.plugins.plenary-nvim'),
    require('custom.plugins.nui-nvim'),
  },
  optional = {
    require('custom.plugins.nvim-web-devicons'),
  },
  configure = function()
    ---@type neotree.Config.Base
    require('neo-tree').setup({
      window = {
        mappings = {
          ['<space>'] = 'noop',
          ['l'] = { 'open' },
          ['h'] = { 'close_node' },
          ['<right>'] = { 'open' },
          ['<left>'] = { 'close_node' },
        },
      },
    })
  end,
}
