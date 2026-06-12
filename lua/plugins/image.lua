-- Inline image rendering via the Kitty Graphics Protocol (Ghostty/kitty/wezterm)
-- ImageMagick is required to display formats other than PNG
return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        doc = {
          -- Show the image under the cursor in a float instead of
          -- rendering every image in the document inline
          inline = false,
          float = true,
        },
      },
    },
  },
}
