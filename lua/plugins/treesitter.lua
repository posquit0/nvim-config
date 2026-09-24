-- Keep the compiled treesitter parsers in sync with the queries they are used with.
--
-- On the `main` branch, nvim-treesitter symlinks site/queries/<lang> straight into
-- its own repo, but compiles parsers into site/parser/<lang>.so and records the
-- upstream commit each was built from in site/parser-info/<lang>.revision. A
-- `:Lazy update` therefore advances every query the moment the plugin moves, while
-- the parsers only follow if the build hook actually runs and succeeds. When they
-- don't, a query referencing a node type the old parser lacks raises on every parse
-- -- and with noice that surfaces as a "noice.nvim" error popup as soon as the
-- cmdline opens (`:e <file>`), pointing nowhere near the real cause.
--
-- LazyVim already declares the build hook, but it is silent on failure and only
-- fires when lazy.nvim decides the plugin changed. Two additions make it reliable:
--
--   1. Re-run the parser update after every `:Lazy update` / `:Lazy sync`, and
--      surface a failure instead of letting it pass unnoticed.
--   2. Repair missing .revision files first. nvim-treesitter decides whether a
--      language is stale by reading that file for every installed language through
--      an `assert(io.open(...))`, so one missing file -- left behind by an install
--      that was interrupted after the queries were linked -- raises before any
--      parser is looked at, and keeps doing so on every later run. Writing the file
--      back empty makes the recorded revision differ from the declared one, so the
--      language is simply treated as stale and rebuilt by the same update pass.

local function repair_missing_revisions()
  local config = require("nvim-treesitter.config")
  local parsers = require("nvim-treesitter.parsers")
  local info_dir = config.get_install_dir("parser-info")

  local repaired = {}
  for _, lang in ipairs(config.get_installed()) do
    local declared = parsers[lang] and parsers[lang].install_info
    local revision_file = vim.fs.joinpath(info_dir, lang .. ".revision")
    if declared and declared.revision and vim.fn.filereadable(revision_file) == 0 then
      vim.fn.writefile({}, revision_file)
      table.insert(repaired, lang)
    end
  end
  return repaired
end

local function update_parsers()
  local ok, TS = pcall(require, "nvim-treesitter")
  if not ok or not TS.update then
    return
  end

  local repaired = repair_missing_revisions()
  if #repaired > 0 then
    vim.notify("Rebuilding parsers with no recorded revision: " .. table.concat(repaired, ", "), vim.log.levels.WARN)
  end

  TS.update(nil, { summary = true }):await(function(err)
    if err then
      vim.notify("nvim-treesitter parser update failed: " .. tostring(err), vim.log.levels.ERROR)
    end
  end)
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = { "LazyUpdate", "LazySync" },
        callback = update_parsers,
      })
    end,
  },
}
