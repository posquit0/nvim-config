-- CodeCompanion: provider-agnostic AI chat / inline assistant, running ALONGSIDE
-- avante (not replacing it). Conflict avoidance vs avante:
--   * keymaps live under <leader>A (capital) — avante keeps <leader>a
--   * its own :CodeCompanion* commands (no overlap with :Avante*)
--   * render-markdown gets "codecompanion" added without dropping avante's "Avante"
--
-- Adapters wired here:
--   * copilot     (default chat/inline) — GitHub Copilot subscription (copilot.lua token)
--   * claude_code (ACP)                 — Claude Code subscription
--   * codex       (ACP, auth=chatgpt)   — ChatGPT subscription
--
-- One-time setup for the ACP CLIs (their bridge is spawned only when you open
-- that adapter, so nothing breaks until then):
--   npm i -g @agentclientprotocol/claude-agent-acp @agentclientprotocol/codex-acp
--   Claude Code:  export CLAUDE_CODE_OAUTH_TOKEN="$(claude setup-token)"
--   Codex:        codex login          (logs in with the ChatGPT subscription)
return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0", -- pin: CodeCompanion iterates fast; docs recommend pinning
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
    -- stylua: ignore
    keys = {
      { "<leader>Aa", "<cmd>CodeCompanionActions<cr>",            mode = { "n", "v" }, desc = "CodeCompanion Actions" },
      { "<leader>Ac", "<cmd>CodeCompanionChat Toggle<cr>",        mode = "n",          desc = "CodeCompanion Chat (toggle)" },
      { "<leader>Ac", "<cmd>CodeCompanionChat Add<cr>",           mode = "v",          desc = "CodeCompanion Add selection" },
      { "<leader>AC", "<cmd>CodeCompanionChat claude_code<cr>",   mode = "n",          desc = "CodeCompanion Chat (Claude Code)" },
      { "<leader>Ax", "<cmd>CodeCompanionChat codex<cr>",         mode = "n",          desc = "CodeCompanion Chat (Codex)" },
      { "<leader>Ai", "<cmd>CodeCompanion<cr>",                   mode = { "n", "v" }, desc = "CodeCompanion Inline" },
    },
    opts = {
      strategies = {
        -- Default to copilot so chat/inline work immediately (Copilot subscription).
        -- Reach Claude Code / Codex via <leader>AC / <leader>Ax, or set
        -- adapter = "claude_code" here to make it the default once it's set up.
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        cmd = { adapter = "copilot" },
      },
      adapters = {
        acp = {
          -- Use the ChatGPT subscription (via `codex login`) instead of an API key
          codex = function()
            return require("codecompanion.adapters").extend("codex", {
              defaults = { auth_method = "chatgpt" },
            })
          end,
        },
      },
    },
  },

  -- Render markdown inside the CodeCompanion chat buffer too, without dropping
  -- avante's "Avante" filetype.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = { "markdown", "Avante", "codecompanion" },
    opts = function(_, opts)
      opts.file_types = opts.file_types or { "markdown" }
      if not vim.tbl_contains(opts.file_types, "codecompanion") then
        table.insert(opts.file_types, "codecompanion")
      end
    end,
  },
}
