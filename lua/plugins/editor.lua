return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      {
        "<F11>",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = require("lazyvim.util").get_root(),
          })
        end,
        desc = "NeoTree File Explorer (root dir)",
      },
      {
        "<LocalLeader><F11>",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            position = "float",
            dir = require("lazyvim.util").get_root(),
          })
        end,
        desc = "NeoTree File Explorer (root dir)",
      },
    },
    opts = {
      -- Close Neo-tree if it is the last window left in the tab
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        -- 2-way binding between vim's cwd and neo-tree's root
        bind_to_cwd = false,
        filtered_items = {
          -- Display differently than normal items
          visible = true,
          hide_dotfiles = true,
          hide_gitignored = false,
        },
      },
    },
  },
}
