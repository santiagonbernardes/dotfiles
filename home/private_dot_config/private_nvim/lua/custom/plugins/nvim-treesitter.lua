local parsers = {
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
}

local function try_to_attach(buf, lang)
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

---@type Plugin
return {
  spec = {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },
  optional = {
    require('custom.plugins.mason-nvim'),
  },
  configure = function()
    local treesitter = require('nvim-treesitter')
    -- TODO: it looks like this can be done async
    treesitter.install(parsers)
    local available_parsers = treesitter.get_available()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup(
        'tree-sitter-config',
        { clear = true }
      ),
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)

        if not language then return end

        local installed_parsers = treesitter.get_installed('parsers')

        if vim.tbl_contains(installed_parsers, language) then
          -- Enable the parser if it is already installed
          try_to_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          -- If a parser is available in `nvim-treesitter`,
          -- auto-install it and enable it after the installation is done
          treesitter
            .install(language)
            :await(function() try_to_attach(buf, language) end)
        else
          -- Try to enable treesitter features in case the parser exists but is not
          -- available from `nvim-treesitter`
          try_to_attach(buf, language)
        end
      end,
    })
  end,
}
