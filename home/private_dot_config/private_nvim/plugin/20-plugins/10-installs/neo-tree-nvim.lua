local specs = require('custom.specs')
vim.pack.add({
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3'),
  },
  specs.plenary_nvim,
  specs.nui_nvim,
  -- Optional
  specs.nvim_web_devicons,
})
