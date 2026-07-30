---@type Plugin
return {
  -- NOTE: the repo has outdated versioning, sticking to master for a while
  spec = {
    src = 'https://github.com/stevearc/conform.nvim',
    version = 'master',
  },
  optional = {
    require('custom.plugins.mason-nvim'),
  },
  configure = function()
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
  end,
}
