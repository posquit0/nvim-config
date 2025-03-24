return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- not strictly required, but recommended
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- Optional image support in preview window: See `# Preview Mode` for more information
      { "3rd/image.nvim", opts = {} },
    },
    lazy = false,
    cmd = "Neotree",
    keys = {
      {
        "<F11>",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = LazyVim.root(),
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
            dir = LazyVim.root(),
          })
        end,
        desc = "NeoTree File Explorer (root dir)",
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
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
