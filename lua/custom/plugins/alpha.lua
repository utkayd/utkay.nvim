return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require 'alpha.themes.dashboard'
      local logo = [[
      88   88 888888 88  dP    db    Yb  dP             88b 88 Yb    dP 88 8b    d8 
      88   88   88   88odP    dPYb    YbdP              88Yb88  Yb  dP  88 88b  d88 
      Y8   8P   88   88"Yb   dP__Yb    8P       .o.     88 Y88   YbdP   88 88YbdP88 
      `YbodP'   88   88  Yb dP""""Yb  dP        `"'     88  Y8    YP    88 88 YY 88 
      ]]

      dashboard.section.header.val = vim.split(logo, '\n')
      dashboard.section.buttons.val = {
        dashboard.button('f', ' ' .. ' Find file', ':FzfLua files<cr>'),
        dashboard.button('n', ' ' .. ' New file', [[<cmd> ene <BAR> startinsert <cr>]]),
        dashboard.button('r', ' ' .. ' Recent files', ':FzfLua oldfiles<cr>'),
        dashboard.button('g', ' ' .. ' Find text', ':FzfLua live_grep<cr>'),
        dashboard.button('c', ' ' .. ' Config', ':FzfLua files cwd=~/.config/nvim<cr>'),
        dashboard.button('s', ' ' .. ' Restore Session', [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button('q', ' ' .. ' Quit', '<cmd> qa <cr>'),
      }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = 'AlphaButtons'
        button.opts.hl_shortcut = 'AlphaShortcut'
      end
      dashboard.section.header.opts.hl = 'AlphaHeader'
      dashboard.section.buttons.opts.hl = 'AlphaButtons'
      dashboard.section.footer.opts.hl = 'AlphaFooter'
      dashboard.opts.layout[1].val = 8

      return dashboard
    end,
    config = function(_, dashboard)
      require('alpha').setup(dashboard.opts)

      -- Display footer with plugin load time
      local stats = require('lazy').stats()
      local ms = stats.startuptime
      dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.loaded .. ' plugins in ' .. ms .. 'ms'
      pcall(vim.cmd.AlphaRedraw)
    end,
  },
}
