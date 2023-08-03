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
            dir = require("lazyvim.util").get_root()
          })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<LocalLeader><F11>",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            position = "float",
            dir = require("lazyvim.util").get_root()
          })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
    }
  }
}
