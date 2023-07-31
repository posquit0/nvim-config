-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

-- <Esc> is too annoying to type
keymap("i", "jkj", "<ESC>")
keymap("t", "jkj", "<C-\\><C-n>")


--[[
  Windows
--]]
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")


--[[
  Tabs
--]]
keymap("n", "<Tab><Tab>", ":tabnew<CR>")
keymap("n", "<Tab>q", ":tabclose<CR>")
keymap("n", "<Tab>o", ":tabonly<CR>")
keymap("n", "<Tab>s", ":tabs<CR>")
keymap("n", "<Tab>^", ":tabfirst<CR>")
keymap("n", "<Tab>$", ":tablast<CR>")
keymap("n", "<Tab>k", ":tabfirst<CR>")
keymap("n", "<Tab>j", ":tablast<CR>")
keymap("n", "<Tab>l", ":tabnext<CR>")
keymap("n", "<Tab>h", ":tabprevious<CR>")
keymap("n", "<Tab>n", ":tabnext<CR>")
keymap("n", "<Tab>p", ":tabprevious<CR>")
keymap("n", "<Tab><Right>", ":tabnext<CR>")
keymap("n", "<Tab><Left>", ":tabprevious<CR>")
keymap("n", "<Tab>1", ":tabnext 1<CR>")
keymap("n", "<Tab>2", ":tabnext 2<CR>")
keymap("n", "<Tab>3", ":tabnext 3<CR>")
keymap("n", "<Tab>4", ":tabnext 4<CR>")
keymap("n", "<Tab>5", ":tabnext 5<CR>")
keymap("n", "<Tab>6", ":tabnext 6<CR>")
keymap("n", "<Tab>7", ":tabnext 7<CR>")
keymap("n", "<Tab>8", ":tabnext 8<CR>")
keymap("n", "<Tab>9", ":tabnext 9<CR>")
