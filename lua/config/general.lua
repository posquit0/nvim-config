-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Automatically change window's cwd to file's dir
vim.opt.autochdir = true

--[[
  Command-line
--]]
-- Enhance command-line completion
vim.opt.wildmenu = true
-- Ignore when expanding wildcards
vim.opt.wildignore = "*.swp,*.swo,*.class"
