-- Tweaks for the lazygit float opened with <leader>gg (snacks.lazygit).
return {
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        -- Keep snacks' lazygit integration ON, but DON'T derive the theme from
        -- the everforest colorscheme — that mapping is washed out. `theme = {}`
        -- disables the highlight-group mapping, and an explicit high-contrast
        -- monokai-style theme is injected below via `config.gui.theme` (snacks
        -- writes config.gui.theme over its generated theme, so this wins).
        --
        -- NOTE: setting `config` replaces snacks' default config block, so
        -- os.editPreset and gui.nerdFontsVersion are restated here explicitly.
        configure = true,
        theme = {},
        config = {
          os = {
            -- edit a file from lazygit in THIS nvim instead of a nested one
            editPreset = "nvim-remote",
          },
          gui = {
            nerdFontsVersion = "3",
            -- Monokai-ish, high contrast on a dark background
            theme = {
              activeBorderColor = { "#a6e22e", "bold" }, -- green
              inactiveBorderColor = { "#75715e" }, -- comment grey
              searchingActiveBorderColor = { "#fd971f", "bold" }, -- orange
              optionsTextColor = { "#66d9ef" }, -- cyan
              selectedLineBgColor = { "#3e3d32" }, -- selection background
              cherryPickedCommitBgColor = { "#3e3d32" },
              cherryPickedCommitFgColor = { "#ae81ff" }, -- purple
              unstagedChangesColor = { "#f92672" }, -- red/pink
              defaultFgColor = { "#f8f8f2" }, -- near-white text
            },
          },
        },

        win = {
          keys = {
            -- snacks' default maps <esc> in terminal mode ("double-esc to normal
            -- mode"), which interferes with lazygit. Disable it; quit lazygit
            -- with its own `q`.
            term_normal = false,
          },
        },
      },
    },
  },
}
