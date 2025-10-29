return {
  'folke/sidekick.nvim',
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = 'tmux',
        enabled = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select() end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Sidekick Select CLI",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").send({ selection = true }) end,
      mode = { "v" },
      desc = "Sidekick Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "v" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<c-Space>",
      function()
        local sidekick = require("sidekick.cli")
        -- Check if we're currently in a terminal buffer (sidekick view)
        if vim.bo.buftype == "terminal" then
          -- If in sidekick, toggle it to close
          sidekick.toggle()
        else
          -- Otherwise, focus it
          sidekick.focus()
        end
      end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Toggle/Focus",
    },
    -- Example of a keybinding to open Claude directly
    {
      "<leader>cc",
      function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
      desc = "Sidekick Claude Toggle",
      mode = { "n", "v" },
    },
  },
}
