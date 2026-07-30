---@type Plugin
return {
  spec = {
    src = 'https://github.com/neovim/nvim-lspconfig',
    version = vim.version.range('2'),
  },
  optional = {
    require('custom.plugins.lazydev-nvim'),
  },
}
