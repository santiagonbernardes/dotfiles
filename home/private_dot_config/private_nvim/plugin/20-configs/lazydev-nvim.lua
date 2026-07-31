vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('lazydev-config', { clear = true }),
  pattern = 'lua',
  callback = function(_)
    -- TODO: move this lsp config to the right spot
    vim.lsp.enable('lua_ls')
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
