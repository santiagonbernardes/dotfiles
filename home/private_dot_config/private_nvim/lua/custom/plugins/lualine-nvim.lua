---@type Plugin
return {
  spec = {
    src = 'https://github.com/nvim-lualine/lualine.nvim',
    version = 'master',
  },
  dependencies = {
    require('custom.plugins.nvim-web-devicons'),
  },
  configure = function()
    require('lualine').setup({
      options = {
        theme = 'dracula',
      },
    })
  end,
}
