---@type conform.setupOpts
require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
  },
  lsp_format = 'fallback',
  default_format_opts = {
    lsp_format = 'fallback',
  },
  format_on_save = {
    lsp_format = 'fallback',
    timeout_ms = 500,
  },
})
