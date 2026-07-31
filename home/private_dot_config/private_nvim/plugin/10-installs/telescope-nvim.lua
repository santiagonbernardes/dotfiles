local specs = require('custom.specs')

vim.pack.add({
  {
    src = 'https://github.com/nvim-telescope/telescope.nvim',
    version = 'master',
  },
  specs.telescope_fzf_native,
  specs.nvim_web_devicons,
})
