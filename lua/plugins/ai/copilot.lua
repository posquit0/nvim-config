-- LazyVim's ai.copilot extra (imported in config.lazy) sets up copilot.lua
-- and feeds completions into blink.cmp via fang2hou/blink-copilot.
-- The full opts are kept explicit here, including the values that match
-- copilot.lua's own defaults, so the behaviour stays visible in this config.
return {
  {
    "zbirenbaum/copilot.lua",
    -- LazyVim's extra sets `build = ":Copilot auth"`, which re-runs auth on
    -- every update and errors once signed in (copilot.lua v3). Only prompt when
    -- no credentials exist yet, so fresh machines still get onboarded.
    build = function()
      local dir = (vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")) .. "/github-copilot"
      local authed = vim.fn.filereadable(dir .. "/auth.db") == 1
        or vim.fn.filereadable(dir .. "/apps.json") == 1
        or vim.fn.filereadable(dir .. "/hosts.json") == 1
      if not authed then
        vim.cmd("Copilot auth")
      end
    end,
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
