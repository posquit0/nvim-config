-- LazyVim's ai.copilot extra (imported in config.lazy) sets up copilot.lua
-- and feeds completions into blink.cmp via fang2hou/blink-copilot.
-- The full opts are kept explicit here, including the values that match
-- copilot.lua's own defaults, so the behaviour stays visible in this config.
return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<Tab><Tab>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
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
