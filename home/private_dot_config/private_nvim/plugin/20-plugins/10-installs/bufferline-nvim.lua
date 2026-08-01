vim.pack.add({
  {
    src = 'https://github.com/akinsho/bufferline.nvim',
    version = vim.version.range('4'),
  },
  require('custom.specs').nvim_web_devicons,
})
