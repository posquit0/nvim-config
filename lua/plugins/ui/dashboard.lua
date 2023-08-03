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


return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      {
        "<F12>",
        "<cmd>Alpha<cr>",
        desc = "Go to Alpha Dashboard",
      },
    },
    config = function(_, dashboard)
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local fortune = require("alpha.fortune")

      -- Header
      dashboard.section.header.val = logo
      dashboard.section.header.opts = {
        position = "center",
        hl = "Title",
      }


      -- Quote
      dashboard.section.quote = {
        type = "text",
        val = fortune(),
        opts = {
          position = "center",
          hl = "Comment",
        }
      }


      -- Buttons
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "String"
        button.opts.hl_shortcut = "Keyword"
      end

      dashboard.section.buttons.opts = {
        spacing = 1,
      }


      -- Version Info
      local function version()
        local version = vim.version()
        local nvim_version_info = " Neovim v" .. version.major .. "." .. version.minor .. "." .. version.patch

        return nvim_version_info
      end

      dashboard.section.version_info = {
        type = "text",
        val = version(),
        opts = {
          position = "center",
          hl = "Number",
        }
      }


      -- Footer
      dashboard.section.footer.opts.hl = "Number"
      dashboard.section.footer.opts.position = "center"


      -- Layout
      dashboard.config.layout = {
        { type = "padding", val = 5 },
        dashboard.section.header,
        { type = "padding", val = 5 },
        dashboard.section.quote,
        { type = "padding", val = 5 },
        dashboard.section.buttons,
        { type = "padding", val = 2 },
        dashboard.section.version_info,
        dashboard.section.footer,
      }
      alpha.setup(dashboard.opts)


      -- Close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local total_plugins = stats.count
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          dashboard.section.footer.val = dashboard.section.footer.val .. "\n⚡ Loaded " .. total_plugins .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
