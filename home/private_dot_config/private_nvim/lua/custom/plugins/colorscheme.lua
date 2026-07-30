---@type Plugin
return {
  spec = { src = 'https://github.com/ray-x/starry.nvim', version = 'master' },

  configure = function()
    require('starry').setup({
      disable = {
        background = true, -- transparent background
      },
    })

    vim.cmd('colorscheme dracula')
  end,
}
