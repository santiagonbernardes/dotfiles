vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('lazydev-config', { clear = true }),
  pattern = 'lua',
  callback = function(_)
    require('lazydev').setup({
      library = {
        {
          path = '${3rd}/luv/library',
          words = { 'vim%.uv' },
        },
      },
    })
  end,
})
