local M = {}

---Notify with optional log level
---@param msg string notification
---@param log_level? vim.log.levels severity
local notify = function(msg, log_level)
  log_level = log_level or vim.log.levels.INFO

  vim.notify(msg, log_level)
end

M.schedule_notify = vim.schedule_wrap(notify)

return M
