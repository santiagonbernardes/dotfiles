---@type Plugin
return {
  -- TODO: remove this plugin after the setup is working as I want.
  -- The only reason I'm using it is to ensure a few binaries are available.
  spec = {
    src = 'https://github.com/mason-org/mason-lspconfig.nvim',
    version = vim.version.range('2'),
  },
  dependencies = {
    require('custom.plugins.mason-nvim'),
    require('custom.plugins.nvim-lspconfig'),
  },
  configure = function()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua-language-server' },
    })
  end,
}
