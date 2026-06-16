-- Only load vim-wakatime once an API key is actually configured. Without a
-- key the plugin prints "[WakaTime] Type :WakaTimeApiKey ..." on every startup
-- (surfaced as a noice popup), because its setup never marks itself done. The
-- gate below keeps the plugin installed but unloaded until a key exists, so a
-- fresh machine starts cleanly.
--
-- Register a key through any source wakatime-cli reads, then restart nvim:
--   * ~/.wakatime.cfg  ->  [settings] api_key = <key>   (then `chmod 600 ~/.wakatime.cfg`)
--   * ~/.wakatime.cfg  ->  [settings] api_key_vault_cmd = <cmd that prints the key>
--                          (most secure — e.g. macOS Keychain:
--                           `security find-generic-password -s wakatime -w`)
--   * $WAKATIME_API_KEY environment variable
local function has_api_key()
  if (vim.env.WAKATIME_API_KEY or "") ~= "" then
    return true
  end

  local cfg = vim.fn.expand("~/.wakatime.cfg")
  if vim.fn.filereadable(cfg) == 0 then
    return false
  end

  for _, line in ipairs(vim.fn.readfile(cfg)) do
    -- a non-empty `api_key`/`apikey`, or an `api_key_vault_cmd`
    if line:match("^%s*api_?key%s*=%s*%S") or line:match("^%s*api_key_vault_cmd%s*=%s*%S") then
      return true
    end
  end

  return false
end

return {
  {
    "wakatime/vim-wakatime",
    cond = has_api_key,
    lazy = false,
  },
}
