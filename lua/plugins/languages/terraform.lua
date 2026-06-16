-- terraform/hcl language tooling is provided by the official
-- lazyvim.plugins.extras.lang.terraform extra (imported in config.lazy):
-- treesitter parsers, terraformls, tflint, terraform_fmt (conform.nvim)
-- and terraform_validate (nvim-lint).
--
-- Neovim's bundled ftplugins (ftplugin/terraform.vim, sourced by
-- ftplugin/hcl.vim) already set commentstring=# %s, but it is kept here
-- explicitly so the behaviour is visible in this config.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "hcl", "terraform" },
  desc = "terraform/hcl commentstring configuration",
  command = "setlocal commentstring=#\\ %s",
})

return {}
