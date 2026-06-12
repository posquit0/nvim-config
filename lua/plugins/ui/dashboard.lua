local logo = {
  [[                                                                   ]],
  [[      ████ ██████           █████      ██                    ]],
  [[     ███████████             █████                            ]],
  [[     █████████ ███████████████████ ███   ███████████  ]],
  [[    █████████  ███    █████████████ █████ ██████████████  ]],
  [[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
  [[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
  [[██████  █████████████████████ ████ █████ █████ ████ ██████]],
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
          -- The action buttons (find file, recent files, grep, session, ...)
          -- come from LazyVim's snacks.dashboard preset and follow the
          -- configured picker automatically
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
