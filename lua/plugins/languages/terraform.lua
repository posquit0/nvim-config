-- terraform/hcl language tooling is provided by the official
-- lazyvim.plugins.extras.lang.terraform extra (imported in config.lazy):
-- treesitter parsers, terraformls, tflint (mason), terraform_fmt (conform.nvim)
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

return {
  -- The lang.terraform extra installs tflint via mason but only wires
  -- terraform_validate into nvim-lint, so tflint never actually runs. Add it.
  -- tflint catches provider/best-practice issues; terraform_validate (kept)
  -- covers `terraform validate` (needs an initialized dir). Both can run.
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      for _, ft in ipairs({ "terraform", "tf" }) do
        local list = opts.linters_by_ft[ft] or {}
        if not vim.tbl_contains(list, "tflint") then
          table.insert(list, "tflint")
        end
        opts.linters_by_ft[ft] = list
      end
    end,
  },
}
