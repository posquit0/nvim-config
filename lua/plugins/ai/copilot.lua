-- LazyVim's ai.copilot extra (imported in config.lazy) sets up copilot.lua
-- and feeds completions into blink.cmp via fang2hou/blink-copilot.
-- Only local overrides of the extra live here.
return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      -- The extra disables the panel; keep it available
      panel = {
        enabled = true,
        auto_refresh = true,
        layout = {
          position = "bottom",
          ratio = 0.4,
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        help = true,
      },
    },
  },
}
