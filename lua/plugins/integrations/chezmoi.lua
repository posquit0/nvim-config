return {
  {
    "dpezto/chezmoi-template.nvim",
    lazy = false,
    opts = {
      apply = { on_save = false },
    },
    keys = {
      { "<leader>sz", "<cmd>Chezmoi pick<cr>", desc = "Chezmoi source files" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "gotmpl" } },
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "chezmoi" },
        providers = {
          chezmoi = {
            name = "chezmoi",
            module = "chezmoi-template.blink",
          },
        },
      },
    },
  },
}
