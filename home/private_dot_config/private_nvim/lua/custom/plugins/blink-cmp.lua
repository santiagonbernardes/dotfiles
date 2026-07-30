local helper = require('custom.plugins._pack-helpers')

---@type Plugin
local plugin = {
  -- TODO: After the maintainer releases v2, change version to v2
  spec = { src = 'https://github.com/saghen/blink.cmp', version = 'main' },
  dependencies = {
    require('custom.plugins.blink-lib'),
  },
  configure = function() require('blink.cmp').setup() end,
}

helper.add_on_change_upinstall_autocmd(
  'blink.cmp',
  ---@diagnostic disable-next-line: undefined-field
  function(_) require('blink.cmp').build():pwait() end
)

return plugin
