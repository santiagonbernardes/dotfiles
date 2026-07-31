local helper = require('custom.helpers.plugins')
local name = 'telescope-fzf-native.nvim'

helper.add_on_change_upinstall_autocmd(
  name,
  function(event) helper.run_system_command(name, { 'make' }, event.data.path) end
)

vim.pack.add({
  require('custom.specs').telescope_fzf_native,
})
