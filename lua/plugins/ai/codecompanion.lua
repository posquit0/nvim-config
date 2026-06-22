-- CodeCompanion: provider-agnostic AI chat / inline assistant, running ALONGSIDE
-- avante (not replacing it). Conflict avoidance vs avante:
--   * keymaps live under <leader>A (capital) — avante keeps <leader>a
--   * its own :CodeCompanion* commands (no overlap with :Avante*)
--   * render-markdown gets "codecompanion" added without dropping avante's "Avante"
--
-- Adapters wired here:
--   * copilot     (default chat/inline) — GitHub Copilot subscription (copilot.lua token)
--   * claude_code (ACP)                 — Claude Code subscription
--   * codex       (ACP, auth=chat-gpt)  — ChatGPT subscription
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
    -- NOTE: an adapter must be passed as `adapter=<name>`. A bare arg
    -- (e.g. `CodeCompanionChat claude_code`) is parsed as a subcommand, ignored,
    -- and the chat falls back to the default adapter — which is why the per-
    -- adapter keymaps previously all opened the default/last-used adapter.
    keys = {
      { "<leader>Aa", "<cmd>CodeCompanionActions<cr>",                  mode = { "n", "v" }, desc = "CodeCompanion Actions" },
      { "<leader>Ac", "<cmd>CodeCompanionChat adapter=copilot<cr>",     mode = "n",          desc = "CodeCompanion Chat (Copilot)" },
      { "<leader>AC", "<cmd>CodeCompanionChat adapter=claude_code<cr>", mode = "n",          desc = "CodeCompanion Chat (Claude Code)" },
      { "<leader>Ax", "<cmd>CodeCompanionChat adapter=codex<cr>",       mode = "n",          desc = "CodeCompanion Chat (Codex)" },
      { "<leader>At", "<cmd>CodeCompanionChat Toggle<cr>",              mode = "n",          desc = "CodeCompanion Chat (toggle last)" },
      { "<leader>Ad", "<cmd>CodeCompanionChat Add<cr>",                 mode = "v",          desc = "CodeCompanion Add selection" },
      -- Inline needs a range so the assistant gets code as context. Normal mode
      -- uses ":%CodeCompanion" → the whole current file (no selecting needed);
      -- visual uses ":CodeCompanion" → the selection ('<,'> auto-prepended).
      -- "<cmd>" would pass no range, which left inline with no context.
      { "<leader>Ai", ":%CodeCompanion<cr>",                            mode = "n",          desc = "CodeCompanion Inline (file)" },
      { "<leader>Ai", ":CodeCompanion<cr>",                             mode = "v",          desc = "CodeCompanion Inline (selection)" },
      -- Insert-mode "AI" chord prefix <M-A> (fire actions without leaving
      -- insert). Add more under it later, e.g. <M-A>c for chat. <M-A>i runs the
      -- inline assistant on the whole current file (vim.cmd avoids the <cmd>
      -- no-range issue and works straight from insert mode).
      { "<M-A>i", function() vim.cmd("%CodeCompanion") end,             mode = "i",          desc = "CodeCompanion Inline (file, from insert)" },
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
        http = {
          -- CodeCompanion's copilot default model is "gpt-4.1", which this
          -- Copilot account doesn't offer; Copilot then silently falls back to
          -- its account default (a Claude model), so the "Copilot" chat answered
          -- as Claude. Pin a GPT model this account actually has.
          -- (List your models with `ga`/the model picker; change as you like.)
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = { model = { default = "gpt-5.4" } },
            })
          end,
        },
        acp = {
          -- Use the ChatGPT subscription (via `codex login`) instead of an API key.
          -- The id must match what codex-acp advertises: "chat-gpt" (hyphen),
          -- not "chatgpt" — otherwise CodeCompanion falls back to the first
          -- advertised method ("api-key") and auth fails.
          codex = function()
            return require("codecompanion.adapters").extend("codex", {
              defaults = { auth_method = "chat-gpt" },
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
