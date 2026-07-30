---@type Plugin
return {
  spec = { src = 'https://github.com/kdheepak/lazygit.nvim', version = 'main' },
  optional = {
    require('custom.plugins.plenary-nvim'),
  },
}
