---@type Plugin
return {
  -- Deals with anoying config file diagnostics
  spec = { src = 'https://github.com/folke/lazydev.nvim', version = 'main' },
  configure = function()
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
  end,
}
