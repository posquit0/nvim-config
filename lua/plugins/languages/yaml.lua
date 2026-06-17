-- YAML linting + formatting (not configured by LazyVim defaults).
--   * yamllint  -> nvim-lint (style/syntax lint: indentation, line length, ...)
--   * yamlfmt   -> conform   (format-on-save)
-- Both are installed via mason. For schema-aware validation/completion
-- (k8s, GitHub Actions, ...) additionally import lang.yaml in config.lazy.
return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "yamllint", "yamlfmt" } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.yaml = { "yamllint" }
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.yaml = { "yamlfmt" }
    end,
  },
}
