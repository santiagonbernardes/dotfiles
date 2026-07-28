vim.loader.enable()              -- Faster startup by caching compiled Lua modules

vim.g.mapleader        = ' '     -- Maps <space> to leader
vim.g.maplocalleader   = "\\"    -- Maps localleader to \

-- Options
vim.opt.mouse          = 'a'     -- Enables mouse
vim.opt.number         = true    -- Show line number
vim.opt.relativenumber = true    -- Show relative number 
vim.opt.undofile       = true    -- Persistent undo
vim.opt.autoindent     = true    -- Use auto indent
vim.opt.expandtab      = true    -- Convert tabs to spaces
vim.opt.ignorecase     = true    -- Ignore case during search
vim.opt.incsearch      = true    -- Show search matches while typing
vim.opt.infercase      = true    -- Infer case in built-in completion
vim.opt.shiftwidth     = 2       -- Use this number of spaces for indentation
vim.opt.smartcase      = true    -- Respect case if search pattern has upper case
vim.opt.smartindent    = true    -- Make indenting smart
vim.opt.spelloptions   = 'camel' -- Treat camelCase word parts as separate words
vim.opt.tabstop        = 2       -- Show tab as this number of spaces
vim.opt.virtualedit    = 'block' -- Allow going past end of line in blockwise mode
vim.opt.clipboard      = 'unnamedplus' -- Sync clipboard with system clipboard
vim.opt.termguicolors  = true          -- True color support
vim.opt.splitbelow     = true          -- New windows below current 
vim.opt.splitright     = true          -- New windows to the right of current 
vim.opt.wrap           = false         -- Don't wrap long lines
vim.opt.incsearch      = true          -- Incremental search
vim.opt.scrolloff      = 24            -- Number of lines around the cursor
vim.opt.colorcolumn    = "80"          -- Show column at the 80th char
vim.opt.spelllang      = "en,pt"       -- Languages to use in spell checking


-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = "Remove search highlight" })
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down (selected lines)" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up (selected lines)" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down (selected lines)" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up (selected lines)" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down (selected lines)" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up (selected lines)" })
-- Keep cursor in the middle while navigating and searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight copied text',
  group = vim.api.nvim_create_augroup('custom-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
