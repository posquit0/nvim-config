return {
  -- Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "BufReadPost",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<M-space>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      -- panel = { enabled = false },
      filetypes = {
        yaml = true,
        markdown = true,
        help = true,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          LazyVim.lsp.on_attach(function()
            copilot_cmp._on_insert_enter({})
          end, "copilot")
        end,
        specs = {
          {
            "hrsh7th/nvim-cmp",
            optional = true,
            ---@param opts cmp.ConfigSchema
            opts = function(_, opts)
              table.insert(opts.sources, 1, {
                name = "copilot",
                group_index = 1,
                priority = 100,
              })
            end,
          },
        },
      },
    },
  },
}
