---@type Plugin
return {
  spec = { src = 'https://github.com/abecodes/tabout.nvim', version = 'master' },
  dependencies = {
    require('custom.plugins.nvim-treesitter')
  },
  configure = function() require('tabout').setup({}) end,
}
