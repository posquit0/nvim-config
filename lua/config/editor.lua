--[[
  Encoding
--]]
-- File-content encoding candidates for the current buffer
-- NOTE: `encoding` itself is always utf-8 in Neovim and must not be set
vim.opt.fileencodings = "utf-8,euc-kr"

--[[
  Formatting
--]]
-- When 'softtabstop' is negative, the value of 'shiftwidth' is used
-- NOTE: tabstop/shiftwidth/expandtab/smartindent are already set by LazyVim
vim.opt.softtabstop = -1

--[[
  Backup and Swap
--]]
-- No fucking swap files
vim.opt.swapfile = false
-- Don’t create backups when editing files in certain directories
vim.opt.backupskip = "/private/tmp/*,/tmp/*"
