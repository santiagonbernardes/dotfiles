---@type Plugin
return {
  spec = {
    src = 'https://github.com/windwp/nvim-autopairs',
    version = 'master',
  },
  configure = function() require('nvim-autopairs').setup() end,
}
