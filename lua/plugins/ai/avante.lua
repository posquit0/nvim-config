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
-- One-time prerequisite (the binary is spawned only when you actually use
-- Avante, e.g. :AvanteAsk):
--   npm i -g @zed-industries/claude-code-acp
-- avante's built-in claude-code default calls `claude-agent-acp`, which is not
-- published on npm, so point it at Zed's maintained adapter (`claude-code-acp`).
return {
  {
    "yetone/avante.nvim",
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = "claude-code",
      acp_providers = {
        ["claude-code"] = {
          command = "claude-code-acp",
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
