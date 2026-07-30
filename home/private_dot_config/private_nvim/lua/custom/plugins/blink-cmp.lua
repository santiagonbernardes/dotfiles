---@type Plugin
return {
  -- TODO: After the maintainer releases v2, change version to v2
  spec = { src = 'https://github.com/saghen/blink.cmp', version = 'main' },
  dependencies = {
    require('custom.plugins.blink-lib'),
  },
  configure = function() require('blink.cmp').setup() end,
}
