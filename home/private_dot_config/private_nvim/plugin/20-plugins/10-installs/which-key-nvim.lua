local specs = require('custom.specs')

vim.pack.add({
  {
    src = 'https://github.com/folke/which-key.nvim',
    version = vim.version.range('3'),
  },
  specs.nvim_web_devicons,
  specs.mini_icons,
})
