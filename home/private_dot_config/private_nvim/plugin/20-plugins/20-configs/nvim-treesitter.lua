--- Attaches treesitter to a buffer for a given language
---@param buffer_id integer
---@param language string
local function try_to_attach(buffer_id, language)
  -- Check if a parser exists and load it
  if not vim.treesitter.language.add(language) then return end
  -- Enable syntax highlighting and other treesitter features
  vim.treesitter.start(buffer_id, language)

  -- Check if treesitter indentation is available for this language, and if
  -- so enable it in case there is no indent query, the indentexpr will
  -- fallback to the vim's built in one
  local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

  -- Enable treesitter based indentation
  if has_indent_query then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('tree-sitter-config', { clear = true }),
  callback = function(args)
    local buffer_id, full_file_path = args.buf, args.match
    local language = vim.treesitter.language.get_lang(full_file_path)

    if not language then return end

    local treesitter = require('nvim-treesitter')
    local installed_parsers = treesitter.get_installed('parsers')

    if vim.tbl_contains(installed_parsers, language) then
      -- Enable the parser if it is already installed
      try_to_attach(buffer_id, language)
      return
    end

    local available_parsers = treesitter.get_available()
    if vim.tbl_contains(available_parsers, language) then
      -- If a parser is available in `nvim-treesitter`,
      -- auto-install it and enable it after the installation is done
      treesitter
        .install(language)
        :await(function() try_to_attach(buffer_id, language) end)
      return
    end
    -- Try to enable treesitter features in case the parser exists but is not
    -- available from `nvim-treesitter`
    try_to_attach(buffer_id, language)
  end,
})

require('nvim-treesitter').install({
  'bash',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'rust',
  'python',
  'query',
  'vim',
  'vimdoc',
  'ruby',
})
