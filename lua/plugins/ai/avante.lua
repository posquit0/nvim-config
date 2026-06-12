-- LazyVim's ai.avante extra (imported in config.lazy) sets up avante.nvim
-- with provider = "copilot", the build step, and the <leader>a keymaps.
-- The extra marks its img-clip.nvim and render-markdown.nvim integrations
-- as `optional`, so install them here to keep image pasting and rendered
-- markdown in the Avante sidebar.
return {
  { "HakonHarnes/img-clip.nvim" },
  { "MeanderingProgrammer/render-markdown.nvim" },
}
