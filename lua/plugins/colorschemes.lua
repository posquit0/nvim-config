return {
  {
    "sainnhe/everforest",
    lazy = false, -- Make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- Make sure to load this before all the other start plugins
    config = function()
      -- The configuration options should be placed before `colorscheme` command
      vim.opt.background = "dark"

      -- Available values: 'hard', 'medium'(default), 'soft'
      vim.g.everforest_background = "hard"
      vim.g.everforest_better_performance = 1

      vim.cmd([[colorscheme everforest]])
    end,
  },
  {
    "sainnhe/sonokai",
    lazy = true,
    config = function()
      -- The configuration options should be placed before `colorscheme` command
      vim.g.sonokai_style = "andromeda"
      vim.g.sonokai_better_performance = 1

      vim.cmd([[colorscheme sonokai]])
    end,
  },
}
