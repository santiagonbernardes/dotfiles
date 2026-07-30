---@type Plugin
return {
  spec = {
    src = 'https://github.com/lukas-reineke/indent-blankline.nvim',
    version = vim.version.range('3'),
  },
  configure = function()
    require('ibl').setup({
      exclude = {
        filetypes = {
          'dashboard',
        },
      },
    })
  end,
}
