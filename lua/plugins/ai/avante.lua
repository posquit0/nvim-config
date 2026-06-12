-- LazyVim's ai.avante extra (imported in config.lazy) sets up avante.nvim
-- with provider = "copilot", the build step, and the <leader>a keymaps.
-- The extra marks its img-clip.nvim and render-markdown.nvim integrations
-- as `optional`, so install them here to keep image pasting and rendered
-- markdown in the Avante sidebar.
return {
  {
    "yetone/avante.nvim",
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = "copilot",
      providers = {
        -- Kept for switching to the claude provider via :AvanteSwitchProvider.
        -- NOTE: `model` is an older Sonnet snapshot — refresh it before use.
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
