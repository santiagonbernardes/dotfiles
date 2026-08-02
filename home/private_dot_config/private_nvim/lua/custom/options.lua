vim.opt.mouse = 'a' -- Enables mouse
vim.opt.number = true -- Show line number
vim.opt.relativenumber = true -- Show relative number
vim.opt.undofile = true -- Persistent undo
vim.opt.autoindent = true -- Use auto indent
vim.opt.breakindent = true -- Indent wrapped lines to match line start
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.ignorecase = true -- Ignore case during search
vim.opt.incsearch = true -- Show search matches while typing
vim.opt.infercase = true -- Infer case in built-in completion
vim.opt.shiftwidth = 2 -- Use this number of spaces for indentation
vim.opt.smartcase = true -- Respect case if search pattern has upper case
vim.opt.smartindent = true -- Make indenting smart
vim.opt.spelloptions = 'camel' -- Treat camelCase word parts as separate words
vim.opt.tabstop = 2 -- Show tab as this number of spaces
vim.opt.virtualedit = 'block' -- Allow going past end of line in blockwise mode
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard with system clipboard
vim.opt.termguicolors = true -- True color support
vim.opt.splitbelow = true -- New windows below current
vim.opt.splitright = true -- New windows to the right of current
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.incsearch = true -- Incremental search
vim.opt.scrolloff = 24 -- Number of lines around the cursor
vim.opt.colorcolumn = '80' -- Show column at the 80th char
vim.opt.spelllang = 'en,pt' -- Languages to use in spell checking
vim.opt.signcolumn = 'yes:1' -- Always show the sign column with 1 space
vim.opt.ruler = false -- Don't show cursor coordinates
vim.opt.fillchars = 'eob: ,fold:╌' -- Replace symbols on fold and end of buffer

-- built-in autocompletion
vim.opt.autocomplete = true
-- TODO: review these options
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
vim.opt.pumborder = 'rounded'
vim.opt.complete = {
  'o', -- Omnifunc (LSP),
  '.', -- 	.	scan the current buffer (default)
  'w', -- 	w	scan buffers from other windows (default)
  'b', -- 	b	scan other loaded buffers that are in the buffer list (default)
  'u', -- 	u	scan the unloaded buffers that are in the buffer list (default)
  't', -- 	t	tag completion (default)
}

-- 'complete' 'cpt'	string	(default ".,w,b,u,t")

-- 	U	scan the buffers that are not in the buffer list
-- 	k	scan the files given with the 'dictionary' option
-- 	kspell  use the currently active spell checking |spell|
-- 	k{dict}	scan the file {dict}.  Several "k" flags can be given,
-- 		patterns are valid too.  For example: >vim
-- 			set cpt=k/usr/dict/*,k~/spanish
-- <	s	scan the files given with the 'thesaurus' option
-- 	s{tsr}	scan the file {tsr}.  Several "s" flags can be given, patterns
-- 		are valid too.
-- 	i	scan current and included files
-- 	d	scan current and included files for defined name or macro
-- 		|i_CTRL-X_CTRL-D|
-- 	]	tag completion

-- 	f	scan the buffer names (as opposed to buffer contents)
-- 	F{func}	call the function {func}.  Multiple "F" flags may be
-- 		specified.  Refer to |complete-functions| for details on how
-- 		the function is invoked and what it should return.  The value
-- 		can be the name of a function or a |Funcref|.  For |Funcref|
-- 		values, spaces must be escaped with a backslash ('\'), and
-- 		commas with double backslashes ('\\') (see |option-backslash|).
-- 		Unlike other sources, functions can provide completions
-- 		starting from a non-keyword character before the cursor, and
-- 		their start position for replacing text may differ from other
-- 		sources.  If the Dict returned by the {func} includes
-- 		`{"refresh": "always"}`, the function will be invoked again
-- 		whenever the leading text changes.
-- 		If generating matches is potentially slow, call
-- 		|complete_check()| periodically to keep Vim responsive.  This
-- 		is especially important for |ins-autocompletion|.
-- 	F	equivalent to using "F{func}", where the function is taken
-- 		from the 'completefunc' option.
-- 	o	equivalent to using "F{func}", where the function is taken
-- 		from the 'omnifunc' option.
