-- Enhancements on top of LazyVim's gitsigns defaults.
-- Using the `function(_, opts)` form so LazyVim's signs and its hunk keymaps
-- (]h/[h, <leader>gh*, the `ih` text object) are preserved and only extended.
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      -- Inline blame (virtual text at end of the current line)
      opts.current_line_blame = true
      opts.current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300, -- ms; small delay so it isn't distracting while moving
        ignore_whitespace = false,
      }
      opts.current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> · <summary>"

      -- Show intra-line word-level diff inside changed regions (off by default;
      -- toggle with <leader>ghw below)
      opts.word_diff = false

      -- Also attach in untracked files so their additions get signs
      opts.attach_to_untracked = true

      -- Tint the line-NUMBER column by git status on changed lines
      -- (GitSignsAddNr/ChangeNr/DeleteNr) — the "numbers show git state" look.
      -- Needs 'number' or 'relativenumber' on (both are). linehl tints the whole
      -- line and is louder, so it stays off and is toggleable instead.
      opts.numhl = true
      opts.linehl = false

      -- Rounded border for the hunk preview popup
      opts.preview_config = { border = "rounded", style = "minimal", relative = "cursor", row = 0, col = 1 }

      -- Extend (not replace) LazyVim's on_attach to add toggle keymaps
      local parent_on_attach = opts.on_attach
      opts.on_attach = function(buffer)
        if parent_on_attach then
          parent_on_attach(buffer)
        end

        local gs = package.loaded.gitsigns
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc, silent = true })
        end

        map("n", "<leader>ght", gs.toggle_current_line_blame, "Toggle Line Blame")
        map("n", "<leader>ghw", gs.toggle_word_diff, "Toggle Word Diff")
        map("n", "<leader>ghx", gs.toggle_deleted, "Toggle Deleted")
        map("n", "<leader>ghn", gs.toggle_numhl, "Toggle Number Highlight")
        map("n", "<leader>ghl", gs.toggle_linehl, "Toggle Line Highlight")
      end

      return opts
    end,
  },
}
