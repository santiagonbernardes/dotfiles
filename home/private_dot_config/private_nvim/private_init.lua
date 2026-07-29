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
  -- File explorer
  -- Dependencies
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  -- optional, but recommended
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  -- Plugin
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  -- Tmux
  { src = 'https://github.com/christoomey/vim-tmux-navigator' },
  -- Picker/fuzzy-finder
  -- Dependencies
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
  -- optional
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  -- Plugin
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
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
require('blink.cmp').setup()

-- ### File explorer
---@type neotree.Config.Base
require('neo-tree').setup({
  window = {
    mappings = {
      ['<space>'] = 'noop',
      ['l'] = { 'open' },
      ['h'] = { 'close_node' },
      ['<right>'] = { 'open' },
      ['<left>'] = { 'close_node' },
    }
  }
})

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

local function build(what_to_build, build_cmd, cwd)
  local result = vim.system(build_cmd, { cwd = cwd })
  if result.code == 0 then return end

  local stderr = result.stderr or ''
  local stdout = result.stdout or ''
  local output = stderr ~= '' and stderr or stdout
  if output == '' then output = 'No output from build command.' end
  vim.notify(
    ('Build failed for %s:\n%s'):format(
      what_to_build, output
    ), vim.log.levels.ERROR
  )
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

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    local name = event.data.spec.name
    local kind = event.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    local tl_fzf_native = 'telescope-fzf-native.nvim'
    local ts = 'nvim-treesitter'
    local blink = 'blink.cmp'

    if name == tl_fzf_native and vim.fn.executable 'make' == 1 then
      build(tl_fzf_native, { 'make' }, event.data.path)
      return
    end
    if name ==  ts then
      if not event.data.active then
          vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
      return
    end

    if name == blink then
      require('blink.cmp').build():pwait()
    end
  end,
  })

-- # Diagnostics
vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  }
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
vim.keymap.set('n', '<leader>e', function ()
  require('neo-tree.command').execute({ toggle = true })
end, { desc = 'Open File [E]xplorer' })
vim.keymap.set('n', "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { desc = 'Move to the left pane/window' })
vim.keymap.set('n', "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { desc = 'Move to the pane/window below' })
vim.keymap.set('n', "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { desc = 'Move to the pane/window above' })
vim.keymap.set('n', "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { desc = 'Move to the right pane/window' })
vim.keymap.set('n', "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", { desc = 'Move to the previous pane/window' })

-- Picker/fuzzy-finder
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind with [G]rep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind in [B]uffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind in [Help]' })
