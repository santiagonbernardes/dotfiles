---@type Plugin
return {
  spec = {
    src = 'https://github.com/folke/which-key.nvim',
    version = vim.version.range('3'),
  },
  optional = {
    require('custom.plugins.nvim-web-devicons'),
    require('custom.plugins.mini-icons'),
  },
  configure = function()
    require('which-key').setup({
      preset = 'helix',
    })
  end,
}
