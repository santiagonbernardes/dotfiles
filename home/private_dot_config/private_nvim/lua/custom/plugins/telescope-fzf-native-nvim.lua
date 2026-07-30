local helper = require('custom.plugins._pack-helpers')
local name = 'telescope-fzf-native.nvim'

---@type Plugin
local plugin = {
  spec = {
    src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    version = 'main',
  },
}

helper.add_on_change_upinstall_autocmd(
  name,
  function(event) helper.run_system_command(name, { 'make' }, event.data.path) end
)
return plugin
