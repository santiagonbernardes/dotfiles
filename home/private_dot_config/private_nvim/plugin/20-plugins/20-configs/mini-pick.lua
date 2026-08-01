-- Centered on screen (From docs)
local win_config = function()
  local GOLDEN_RATIO = 0.618
  local height = math.floor(GOLDEN_RATIO * vim.o.lines)
  local width = math.floor(GOLDEN_RATIO * vim.o.columns)
  return {
    anchor = 'NW',
    height = height,
    width = width,
    row = math.floor(0.5 * (vim.o.lines - height)),
    col = math.floor(0.5 * (vim.o.columns - width)),
  }
end

require('mini.pick').setup({ window = { config = win_config } })
