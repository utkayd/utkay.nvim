return {
  {
    'catppuccin/nvim',
    priority = 1000,
    opts = {},
    config = function()
      require('catppuccin').setup {
        transparent_background = false, -- Keep this false to preserve colors
        custom_highlights = function(colors)
          return {
            -- Line numbers
            LineNr = { fg = colors.overlay2 },

            -- Make backgrounds transparent (inherit from terminal)
            Normal = { bg = 'NONE' },
            NormalNC = { bg = 'NONE' },
            NormalFloat = { bg = 'NONE' },
            FloatBorder = { bg = 'NONE' },
            Pmenu = { bg = 'NONE' },
            SignColumn = { bg = 'NONE' },
            -- Uncomment if you want statusline/tabline transparent too:
            StatusLine = { bg = 'NONE' },
            TabLine = { bg = 'NONE' },
            TabLineFill = { bg = 'NONE' },
            TabLineSel = { bg = 'NONE' },

            -- Current line highlight
            CursorLine = { bg = colors.surface0 },
            CursorLineNr = { fg = colors.yellow, bg = colors.surface0, style = { 'bold' } },
          }
        end,
      }
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
}
