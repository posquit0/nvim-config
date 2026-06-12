-- NOTE: Options that match LazyVim defaults are not repeated here:
-- number, relativenumber, signcolumn, cursorline, showmode, termguicolors, ...
-- See https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

--[[
  Wrapping
--]]
-- Lines longer than the window width wrap and continue on the next line
vim.opt.wrap = true
-- Wrap at the last character that fits instead of at a 'breakat' character
vim.opt.linebreak = false
-- Wrapped lines continue visually indented, preserving horizontal blocks
vim.opt.breakindent = true
-- String to put at the start of lines that have been wrapped
vim.opt.showbreak = "» "

--[[
  Tabline
--]]
-- Always show the tabline
vim.opt.showtabline = 2

--[[
  Brackets
--]]
-- Briefly jump to the matching bracket when inserting one
vim.opt.showmatch = true
-- Tenths of a second to show the matching bracket
vim.opt.matchtime = 5
