require('neo-tree').setup({
  window = {
    mappings = {
      ['<space>'] = 'noop',
      ['l'] = { 'open' },
      ['h'] = { 'close_node' },
      ['<right>'] = { 'open' },
      ['<left>'] = { 'close_node' },
    },
  },
})
