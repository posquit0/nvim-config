-- Support EditorConfig
vim.g.editorconfig = true

--[[
  Encoding
--]]
-- String-encoding used internally and for RPC communication
vim.opt.encoding = "utf-8"
-- File-content encoding for the current buffer
vim.opt.fileencodings = "utf-8,euc-kr"
-- Add empty newlines at the end of files
vim.opt.endofline = true

--[[
  Formatting
--]]
-- Set the default tabstop
vim.opt.tabstop = 2
-- When 'softtabstop' is negative, the value of 'shiftwidth' is used
vim.opt.softtabstop = -1
-- Set the default shift width for indents
vim.opt.shiftwidth = 2
-- Make tabs into spaces (set by tabstop)
vim.opt.expandtab = true
-- Smarter tab levels
vim.opt.smarttab = true
-- Copy indent from current line when starting a new line
vim.opt.autoindent = true
-- Do smart autoindenting when starting a new line
vim.opt.smartindent = true

--[[
  Match and Search
--]]
-- Highlight searches
vim.opt.hlsearch = true
-- Ignore case of searches
vim.opt.ignorecase = true
-- Be sensitive when there's a capital letter
vim.opt.smartcase = true
-- Highlight dynamically as pattern is typed
vim.opt.incsearch = true

--[[
  Backup and Swap
--]]
-- Maintain undo history between sessions
vim.opt.undofile = true
-- Set maximum number of changes that can be undone
vim.opt.undolevels = 256
-- Don’t create backups when editing files in certain directories
vim.opt.backupskip = "/private/tmp/*,/tmp/*"
