-- `:!cmd` output is invisible with noice enabled: noice turns on `ext_messages`
-- (via vim.ui_attach), so Neovim stops rendering messages and emits them as UI
-- events instead. Shell output arrives as the `shell_out`/`shell_err`/`shell_ret`
-- message kinds, which noice has no route for, so they fall through to the
-- default `notify` view — a toast that fades before you can read it.
-- Routing them to a popup keeps the rest of the noice UI intact.
return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.routes = opts.routes or {}
      table.insert(opts.routes, {
        filter = {
          event = "msg_show",
          any = {
            { kind = "shell_out" },
            { kind = "shell_err" },
            { kind = "shell_ret" },
          },
        },
        view = "popup",
      })
      return opts
    end,
  },
}
