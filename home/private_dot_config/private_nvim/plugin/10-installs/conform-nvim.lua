vim.pack.add({
  {
    src = 'https://github.com/stevearc/conform.nvim',
    version = 'master',
  },
  require('custom.specs').mason_nvim,
})
