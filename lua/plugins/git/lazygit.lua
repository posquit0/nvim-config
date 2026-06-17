-- Tweaks for the lazygit float opened with <leader>gg (snacks.lazygit).
return {
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        -- Don't let snacks generate a lazygit theme from the Neovim colorscheme
        -- (it maps everforest highlight groups onto lazygit, which reads poorly).
        -- With this off, lazygit just uses ~/.config/lazygit/config.yml as usual,
        -- so set your preferred `gui.theme` there.
        -- Trade-off: snacks no longer injects os.editPreset = "nvim-remote";
        -- add it to your own config.yml if you want lazygit to edit in this nvim.
        configure = false,

        win = {
          keys = {
            -- Fixes the severe input lag. snacks' default maps <esc> in terminal
            -- mode ("double-esc to normal mode"); inside lazygit that makes
            -- Neovim wait `timeoutlen` on every <esc>/escape-sequence key (arrows,
            -- etc.) to disambiguate, so each keystroke stalls. lazygit uses <esc>
            -- constantly, so disabling this remap lets keys pass straight through.
            -- Quit lazygit with its own `q`.
            term_normal = false,
          },
        },
      },
    },
  },
}
