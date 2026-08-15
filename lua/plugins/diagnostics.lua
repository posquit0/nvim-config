-- Diagnostics display: long messages (e.g. terraform validate errors) are
-- unreadable as end-of-line virtual text. Disable virtual_text and instead
-- show the full message as virtual lines below the cursor line only.
-- LazyVim passes opts.diagnostics to vim.diagnostic.config(), so this
-- applies to nvim-lint diagnostics as well as LSP ones.
-- <leader>cd (float) and trouble (<leader>xx) remain available.
--
-- Some tools emit the same message many times at the same position: e.g.
-- `terraform validate -json` reports one "Module not installed" error per
-- uninstalled module, and those diagnostics carry no source range, so
-- nvim-lint places every one of them at line 1 col 1. Rendered as virtual
-- lines that becomes a wall of identical text above the first line.
--
-- The fix below is display-only: the diagnostic list itself is untouched, so
-- trouble, <leader>cd and vim.diagnostic.get() still see every diagnostic.
--   1. drop exact duplicates (same lnum + col + severity + message)
--   2. cap how many virtual lines a single line is allowed to render
--
-- Dedup is per-namespace (handlers are invoked once per namespace), which
-- covers duplicates coming from one source. The same message reported by two
-- different sources (terraformls *and* terraform_validate) is not collapsed.

local MAX_VIRTUAL_LINES_PER_LINE = 2

local function dedup(diagnostics)
  local seen, out = {}, {}
  for _, d in ipairs(diagnostics) do
    local key = table.concat({
      d.lnum or 0,
      d.col or 0,
      d.severity or vim.diagnostic.severity.ERROR,
      d.message or "",
    }, "\0")
    if not seen[key] then
      seen[key] = true
      out[#out + 1] = d
    end
  end
  return out
end

-- keep at most `limit` diagnostics per line, most severe (then leftmost) first
local function cap_per_line(diagnostics, limit)
  local order = {}
  for i, d in ipairs(diagnostics) do
    order[d] = i
  end
  table.sort(diagnostics, function(a, b)
    local sa, sb = a.severity or 1, b.severity or 1
    if sa ~= sb then
      return sa < sb
    end
    local ca, cb = a.col or 0, b.col or 0
    if ca ~= cb then
      return ca < cb
    end
    return order[a] < order[b] -- table.sort is not stable; keep input order
  end)

  local count, out = {}, {}
  for _, d in ipairs(diagnostics) do
    local lnum = d.lnum or 0
    count[lnum] = (count[lnum] or 0) + 1
    if count[lnum] <= limit then
      out[#out + 1] = d
    end
  end
  return out
end

local function wrap_handler(name, transform)
  local handler = vim.diagnostic.handlers[name]
  if not handler or not handler.show then
    return
  end
  local show = handler.show
  vim.diagnostic.handlers[name] = vim.tbl_extend("force", {}, handler, {
    show = function(ns, bufnr, diagnostics, opts)
      return show(ns, bufnr, transform(diagnostics), opts)
    end,
  })
end

-- guard: this file is evaluated once by lazy.nvim, but re-sourcing it during
-- config work would otherwise stack wrappers on top of each other
if not vim.g._diagnostic_dedup_installed then
  vim.g._diagnostic_dedup_installed = true

  for _, name in ipairs({ "virtual_text", "underline", "signs" }) do
    wrap_handler(name, dedup)
  end

  wrap_handler("virtual_lines", function(diagnostics)
    return cap_per_line(dedup(diagnostics), MAX_VIRTUAL_LINES_PER_LINE)
  end)
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
        virtual_lines = { current_line = true },
      },
    },
  },
}
