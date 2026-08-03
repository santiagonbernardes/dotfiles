local specs = require('custom.specs')

vim.pack.add({
  specs.mini_icons,
  specs.nvim_web_devicons,
  specs.mini_extra, -- More pickers
  { src = 'https://github.com/nvim-mini/mini.pick', version = 'main' },
})
