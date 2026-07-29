vim.loader.enable()              -- Faster startup by caching compiled Lua modules

vim.g.mapleader        = ' '     -- Maps <space> to leader
vim.g.maplocalleader   = "\\"    -- Maps localleader to \

-- # Options
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

-- # Plugins
vim.pack.add({
  --  Colorscheme
  { src = "https://github.com/ray-x/starry.nvim" },
  --  Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  -- LSP
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  -- Mason (LSPs, formatters, debuggers, etc)
  { src = 'https://github.com/mason-org/mason.nvim' },
  -- TODO: remove this dependency after the setup is working as I want.
  -- The only reason I'm using it is to ensure a few binaries are available.
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  -- Anoying config file diagnostics
  { src = 'https://github.com/folke/lazydev.nvim' },
  -- Completion
  -- Dependency
  { src = 'https://github.com/saghen/blink.lib' },
  -- Plugin
  { src = 'https://github.com/saghen/blink.cmp' },
})

-- ## Plugin configuration
-- ### Colorscheme
require('starry').setup({
  disable = {
    background = true, -- transparent background
  },
})

vim.cmd("colorscheme dracula")

-- ### Treesitter
local parsers = {
  'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'rust', 'python',
  'query', 'vim', 'vimdoc', 'ruby',
}
require('nvim-treesitter').install(parsers)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", },
})

-- ### Completion
local cmp = require('blink.cmp')
-- TODO: Do I have to rebuild it every time or can it be a PackChanged
-- autocommand?
cmp.build():pwait()
cmp.setup()

-- # Helper functions
local function treesitter_try_attach(buf, lang)
  -- Check if a parser exists and load it
  if not vim.treesitter.language.add(lang) then return end
  -- Enable syntax highlighting and other treesitter features
  vim.treesitter.start(buf, lang)

  -- Check if treesitter indentation is available for this language, and if
  -- so enable it in case there is no indent query, the indentexpr will
  -- fallback to the vim's built in one
  local has_indent_query = vim.treesitter.query.get(lang, 'indents') ~= nil

  -- Enable treesitter based indentation
  if has_indent_query then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

-- # Autocommands
-- Highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight copied text',
  group = vim.api.nvim_create_augroup('custom-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})


local treesitter = require('nvim-treesitter')
local available_parsers = treesitter.get_available()
local group_treesitter = vim.api.nvim_create_augroup("tree-sitter-config", {})
vim.api.nvim_create_autocmd('FileType', {
  group = group_treesitter,
  callback = function(args)
    -- Treesitter
    local buf, filetype = args.buf, args.match
    local language = vim.treesitter.language.get_lang(filetype)

    if not language then return end

    local installed_parsers = treesitter.get_installed('parsers')

    if vim.tbl_contains(installed_parsers, language) then
      -- Enable the parser if it is already installed
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- If a parser is available in `nvim-treesitter`,
      -- auto-install it and enable it after the installation is done
      require('nvim-treesitter').install(language):await(
        function()
          treesitter_try_attach(buf, language)
        end)
    else
      -- Try to enable treesitter features in case the parser exists but is not
      -- available from `nvim-treesitter`
      treesitter_try_attach(buf, language)
    end
  end,
})

local group_lazydev = vim.api.nvim_create_augroup('lazydev-config', {})
vim.api.nvim_create_autocmd('FileType', {
  group = group_lazydev,
  pattern = 'lua',
  callback = function(_)
    require('lazydev').setup({
      library = {
        {
          path = "${3rd}/luv/library",
          words = { "vim%.uv" },
        },
      },
    })
  end,
})

-- # Keymaps
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
