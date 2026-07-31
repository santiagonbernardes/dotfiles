-- NOTE: leader mapping is set here to prevent conflict with plugins
vim.g.mapleader = ' ' -- Maps <space> to leader
vim.g.maplocalleader = '\\' -- Maps localleader to \

require('custom.options')
require('custom.diagnostics')
require('custom.autocmds')
