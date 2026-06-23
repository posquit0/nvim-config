-- mise integration — https://mise.jdx.dev/mise-cookbook/neovim.html

-- Make mise-managed tools (runtimes, LSP servers, linters, formatters) visible
-- to Neovim — and respect per-project tool versions — by prepending mise's
-- shims to PATH. This runs at spec-build time (startup), before any LSP,
-- conform formatter, or nvim-lint linter is spawned, so Mason/LSP/conform pick
-- up mise tools regardless of how Neovim was launched (GUI, terminal without
-- `mise activate`, etc.). Idempotent and a no-op if mise isn't installed.
local shims = (vim.env.HOME or vim.fn.expand("~")) .. "/.local/share/mise/shims"
if vim.fn.isdirectory(shims) == 1 and not (":" .. (vim.env.PATH or "") .. ":"):find(":" .. shims .. ":", 1, true) then
  vim.env.PATH = shims .. ":" .. vim.env.PATH
end

return {
  -- Treesitter: detect mise config files (mise.toml, .mise.toml,
  -- mise.local.toml, …) so the bundled TOML injection queries highlight the
  -- embedded languages inside task `run` blocks (gated on the is-mise? predicate).
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.treesitter.query.add_predicate("is-mise?", function(_, _, bufnr, _)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(tonumber(bufnr) or 0), ":t")
        return filename:match(".*mise.*%.toml$") ~= nil
      end, { force = true, all = false })
    end,
  },
}
