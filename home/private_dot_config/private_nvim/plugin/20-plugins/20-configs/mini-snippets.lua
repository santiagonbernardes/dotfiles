local mini_snippets = require('mini.snippets')
local gen_loader = require('mini.snippets').gen_loader

mini_snippets.setup({
  snippets = {
    -- Load snippets based on current language by reading files from
    -- `snippets/` subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})

-- NOTE: Thanks to this server I can use the builtin autocomplete.
mini_snippets.start_lsp_server()
