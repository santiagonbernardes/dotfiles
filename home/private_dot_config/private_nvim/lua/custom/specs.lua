local M = {}
M.nvim_web_devicons = {
  src = 'https://github.com/nvim-tree/nvim-web-devicons',
  version = 'master',
}

M.mason_nvim = {
  src = 'https://github.com/mason-org/mason.nvim',
  version = vim.version.range('2'),
}

M.plenary_nvim = {
  src = 'https://github.com/nvim-lua/plenary.nvim',
  version = 'master',
}

M.mini_icons =
  { src = 'https://github.com/nvim-mini/mini.icons', version = 'main' }

M.nui_nvim = {
  src = 'https://github.com/MunifTanjim/nui.nvim',
  version = vim.version.range('0'),
}

M.nvim_treesitter = {
  src = 'https://github.com/nvim-treesitter/nvim-treesitter',
  version = 'main',
}

M.telescope_fzf_native = {
  src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  version = 'main',
}

return M
