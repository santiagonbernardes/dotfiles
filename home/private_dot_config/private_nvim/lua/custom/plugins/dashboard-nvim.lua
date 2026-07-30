---@type Plugin
return {
  spec = {
    src = 'https://github.com/nvimdev/dashboard-nvim',
    version = 'master',
  },
  dependencies = {
    require('custom.plugins.nvim-web-devicons'),
  },
  configure = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('dashboard-config', {}),
      callback = function(_) require('dashboard').setup({}) end,
    })
  end,
}
