-- NOTE: leader mapping is set here to prevent conflict with plugins
vim.g.mapleader = ' ' -- Maps <space> to leader
vim.g.maplocalleader = '\\' -- Maps localleader to \

local function build(what_to_build, build_cmd, cwd)
  local result = vim.system(build_cmd, { cwd = cwd })
  if result.code == 0 then return end

  local stderr = result.stderr or ''
  local stdout = result.stdout or ''
  local output = stderr ~= '' and stderr or stdout
  if output == '' then output = 'No output from build command.' end
  vim.notify(
    ('Build failed for %s:\n%s'):format(what_to_build, output),
    vim.log.levels.ERROR
  )
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    local name = event.data.spec.name
    local kind = event.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    local tl_fzf_native = 'telescope-fzf-native.nvim'
    local ts = 'nvim-treesitter'
    local blink = 'blink.cmp'

    if name == tl_fzf_native and vim.fn.executable('make') == 1 then
      build(tl_fzf_native, { 'make' }, event.data.path)
      return
    end
    if name == ts then
      if not event.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
      return
    end

    if name == blink then require('blink.cmp').build():pwait() end
  end,
})

local plugins = require('custom.plugins')
vim.pack.add(plugins.get_specs(), { confirm = false })
require('custom.options')
require('custom.diagnostics')
require('custom.keymaps')
require('custom.autocmds')
plugins.configure()
