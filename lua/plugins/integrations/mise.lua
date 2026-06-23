-- mise integration — https://mise.jdx.dev/mise-cookbook/neovim.html

-- Make mise-managed tools (runtimes, LSP servers, linters, formatters) visible to Neovim and respect per-project tool versions — by prepending mise's shims to PATH.
local shims = (vim.env.HOME or vim.fn.expand("~")) .. "/.local/share/mise/shims"
if vim.fn.isdirectory(shims) == 1 and not (":" .. (vim.env.PATH or "") .. ":"):find(":" .. shims .. ":", 1, true) then
  vim.env.PATH = shims .. ":" .. vim.env.PATH
end

return {}
