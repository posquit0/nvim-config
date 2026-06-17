-- Tweaks for the lazygit float opened with <leader>gg (snacks.lazygit).
return {
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        -- With this off, lazygit just uses `~/.config/lazygit/config.yml` as usual
        configure = false,

        win = {
          keys = {
            -- Disabling this remap lets keys pass straight through.
            term_normal = false,
          },
        },
      },
    },
  },
}
