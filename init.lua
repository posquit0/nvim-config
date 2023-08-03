-- -- Configure <Leader> and <LocalLeader> keys
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = ","

require("config.lazy")

require("config.general")
require("config.editor")
require("config.visual")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require "config.autocmds"
    require "config.keymaps"
  end,
})
