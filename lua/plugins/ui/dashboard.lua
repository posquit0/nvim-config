local logo = {
  [[                                                                   ]],
  [[      ████ ██████           █████      ██                    ]],
  [[     ███████████             █████                            ]],
  [[     █████████ ███████████████████ ███   ███████████  ]],
  [[    █████████  ███    █████████████ █████ ██████████████  ]],
  [[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
  [[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
  [[██████  █████████████████████ ████ █████ █████ ████ ██████]],
}

local function version()
  local v = vim.version()
  return " Neovim v" .. v.major .. "." .. v.minor .. "." .. v.patch
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<F12>",
        function()
          Snacks.dashboard()
        end,
        desc = "Go to Dashboard",
      },
    },
    opts = {
      dashboard = {
        preset = {
          -- Buttons are written out explicitly (rather than relying on the
          -- LazyVim preset defaults) so the dashboard's actions stay visible
          -- in this config. The pick actions follow the configured picker.
          -- stylua: ignore
          keys = {
            { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File",        action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "g", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "c", desc = "Config",          action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy",            action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit",            action = ":qa" },
          },
          header = table.concat(logo, "\n"),
        },
        sections = {
          { section = "header", padding = 2 },
          { section = "keys", gap = 1, padding = 2 },
          { text = { { version(), hl = "Number" } }, align = "center", padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
