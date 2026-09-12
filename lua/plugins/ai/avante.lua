-- LazyVim's ai.avante extra (imported in config.lazy) sets up avante.nvim
-- with the build step and the <leader>a keymaps. The extra marks its
-- img-clip.nvim and render-markdown.nvim integrations as `optional`, so
-- install them here to keep image pasting and rendered markdown in the
-- Avante sidebar.
--
-- Provider is "claude-code" (an ACP agent) rather than "copilot": copilot.lua
-- v3 stores its credentials in ~/.config/github-copilot/auth.db, but avante's
-- copilot provider still reads the legacy hosts.json/apps.json and errors at
-- startup ("You must setup copilot ..."). The claude-code ACP provider
-- sidesteps that and reuses the Claude Code CLI login (no API key needed when
-- ANTHROPIC_API_KEY is unset). ACP providers also skip avante's per-provider
-- setup, so loading no longer errors.
--
-- ACP adapters are installed by the global mise config (chezmoi):
--   npm:@agentclientprotocol/claude-agent-acp  -> `claude-agent-acp`
--   npm:@agentclientprotocol/codex-acp         -> `codex-acp`
-- They match avante's built-in `command` defaults, so only the overrides below
-- are needed (avante deep-merges them over its defaults).
-- Switch between them with <leader>ap (:AvanteSwitchProvider).
return {
  {
    "yetone/avante.nvim",
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = "claude-code",
      acp_providers = {
        -- avante spawns ACP agents with ONLY `PATH` + this `env`. Without
        -- `USER`, Claude Code can't find its macOS Keychain login and comes up
        -- "Not logged in"; `HOME` lets it read ~/.claude (settings, CLAUDE.md).
        ["claude-code"] = {
          env = {
            HOME = os.getenv("HOME"),
            USER = os.getenv("USER"),
          },
        },
        -- Use the ChatGPT subscription (`codex login`) instead of an API key.
        -- "chat-gpt" reuses an existing login and only opens the browser
        -- sign-in when none exists. Without it avante skips `authenticate`.
        ["codex"] = {
          auth_method = "chat-gpt",
        },
      },
      providers = {
        -- Kept for switching to the API-based claude provider via
        -- :AvanteSwitchProvider. NOTE: `model` is an older Sonnet snapshot —
        -- refresh it before use.
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
      },
    },
  },
  { "HakonHarnes/img-clip.nvim" },
  { "MeanderingProgrammer/render-markdown.nvim" },
}
