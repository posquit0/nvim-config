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

-- terraformls/terraform validate report "provider not found" diagnostics
-- until the module dir has been initialized. Auto-run `terraform init` in the
-- background, once per dir per session.
-- -backend=false: provider schemas are all the LSP needs; skipping backend
-- setup avoids touching remote state / credential prompts from a background
-- job (a manual `terraform init` is still needed before plan/apply).
local tf_init_started = {}

local function tf_buf_dir(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" or name:find("^%w+://") then
    return nil
  end
  return vim.fs.dirname(name)
end

local function tf_init(dir, buf)
  if tf_init_started[dir] or vim.fn.executable("terraform") == 0 then
    return
  end
  tf_init_started[dir] = true
  vim.notify("terraform init started (background): " .. dir, vim.log.levels.INFO, { title = "terraform" })
  vim.system(
    { "terraform", "init", "-upgrade", "-backend=false", "-input=false", "-no-color" },
    { cwd = dir },
    function(out)
      vim.schedule(function()
        if out.code == 0 then
          vim.notify("terraform init done: " .. dir, vim.log.levels.INFO, { title = "terraform" })
          pcall(vim.cmd, "LspRestart terraformls")
          -- re-lint so stale "run terraform init" diagnostics clear without
          -- waiting for the next write
          if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_call(buf, function()
              pcall(function()
                require("lint").try_lint()
              end)
            end)
          end
        else
          vim.notify(
            "terraform init failed: " .. dir .. "\n" .. (out.stderr or ""),
            vim.log.levels.ERROR,
            { title = "terraform" }
          )
        end
      end)
    end
  )
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "terraform", "terraform-vars" },
  desc = "background terraform init for uninitialized module dirs",
  callback = function(ev)
    local dir = tf_buf_dir(ev.buf)
    -- .terraform.lock.hcl (not .terraform/) is what `terraform validate`
    -- actually requires; an interrupted init can leave .terraform/ behind
    -- without a lock file, which used to suppress the auto-init forever.
    if dir and not (vim.uv or vim.loop).fs_stat(dir .. "/.terraform.lock.hcl") then
      tf_init(dir, ev.buf)
    end
  end,
})

-- Catch init-needed states the lock-file check can't see (provider version
-- bumped in versions.tf, module source changed, corrupted .terraform/, ...):
-- diagnostics that require init always tell the user to run `terraform init`,
-- so match on that. tf_init's once-per-dir guard prevents re-init loops when
-- the re-lint after a failed init reports the same diagnostic again.
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  desc = "background terraform init when diagnostics ask for it",
  callback = function(ev)
    if not vim.tbl_contains({ "terraform", "terraform-vars" }, vim.bo[ev.buf].filetype) then
      return
    end
    for _, d in ipairs(ev.data and ev.data.diagnostics or {}) do
      if d.message:find("terraform init", 1, true) then
        local dir = tf_buf_dir(ev.buf)
        if dir then
          tf_init(dir, ev.buf)
        end
        return
      end
    end
  end,
})

return {
  -- The lang.terraform extra installs tflint via mason but only wires
  -- terraform_validate into nvim-lint, so tflint never actually runs. Add it.
  --
  -- terraform_validate is dropped from nvim-lint: it publishes diagnostics
  -- only to the buffer that was linted, so directory-scoped validate results
  -- went stale in sibling buffers until each one was written. terraformls's
  -- validateOnSave (below) covers `terraform validate` instead.
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      for _, ft in ipairs({ "terraform", "tf" }) do
        local list = vim.tbl_filter(function(linter)
          return linter ~= "terraform_validate"
        end, opts.linters_by_ft[ft] or {})
        if not vim.tbl_contains(list, "tflint") then
          table.insert(list, "tflint")
        end
        opts.linters_by_ft[ft] = list
      end
    end,
  },

  -- Run `terraform validate` from the language server on save (experimental
  -- terraform-ls feature): one validate run per save, and diagnostics are
  -- published to every file in the module, so fixing an error in one file
  -- clears it from already-open sibling files immediately.
  -- terraform-ls runs validate within the saved file's folder, so mise's shim
  -- still resolves the project-pinned terraform version.
  -- https://github.com/hashicorp/terraform-ls/blob/main/docs/SETTINGS.md
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {
          init_options = {
            experimentalFeatures = {
              validateOnSave = true,
            },
          },
        },
      },
    },
  },

  -- Same cwd treatment for `terraform fmt`: run from the file's directory so
  -- the shim picks the project-pinned version (fmt reads stdin, so cwd only
  -- affects version resolution).
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        terraform_fmt = {
          cwd = function(_, ctx)
            return vim.fs.dirname(ctx.filename)
          end,
        },
      },
    },
  },
}
