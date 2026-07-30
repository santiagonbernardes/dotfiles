-- NOTE: leader mapping is set here to prevent conflict with plugins
vim.g.mapleader = ' ' -- Maps <space> to leader
vim.g.maplocalleader = '\\' -- Maps localleader to \

local plugins = require('custom.plugins')
vim.pack.add(plugins.get_specs(), { confirm = false })
require('custom.options')
require('custom.diagnostics')
require('custom.keymaps')
require('custom.autocmds')
plugins.configure()
