---@type Plugin
return {
  spec = {
    src = 'https://github.com/nvim-telescope/telescope.nvim',
    version = 'master',
  },
  dependencies = {
    require('custom.plugins.telescope-fzf-native-nvim'),
  },
  optional = {
    require('custom.plugins.nvim-web-devicons'),
  },
}
