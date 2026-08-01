---@class Specs
---@field nvim_web_devicons vim.pack.Spec
---@field mason_nvim vim.pack.Spec
---@field plenary_nvim vim.pack.Spec
---@field mini_icons vim.pack.Spec
---@field nui_nvim vim.pack.Spec
---@field nvim_treesitter vim.pack.Spec
---@field mini_extra vim.pack.Spec

---@type Specs
local M = {
  nvim_web_devicons = {
    src = 'https://github.com/nvim-tree/nvim-web-devicons',
    version = 'master',
  },

  mason_nvim = {
    src = 'https://github.com/mason-org/mason.nvim',
    version = vim.version.range('2'),
  },

  plenary_nvim = {
    src = 'https://github.com/nvim-lua/plenary.nvim',
    version = 'master',
  },

  mini_icons = {
    src = 'https://github.com/nvim-mini/mini.icons',
    version = 'main',
  },

  nui_nvim = {
    src = 'https://github.com/MunifTanjim/nui.nvim',
    version = vim.version.range('0'),
  },

  nvim_treesitter = {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },

  mini_extra = {
    src = 'https://github.com/nvim-mini/mini.extra',
    version = 'main',
  },
}

return M
