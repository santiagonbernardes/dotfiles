require('custom.helpers.plugins').add_on_change_upinstall_autocmd(
  'nvim-treesitter',
  function(event)
    if not event.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
)

vim.pack.add({
  require('custom.specs').nvim_treesitter,
})
