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
            FloatTitle = { bg = 'NONE' },
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

            -- Snacks Dashboard highlights (transparent background)
            SnacksDashboardNormal = { fg = colors.text, bg = 'NONE' },
            SnacksDashboardHeader = { fg = colors.blue, bg = 'NONE', style = { 'bold' } },
            SnacksDashboardIcon = { fg = colors.blue, bg = 'NONE' },
            SnacksDashboardDesc = { fg = colors.text, bg = 'NONE' },
            SnacksDashboardKey = { fg = colors.sapphire, bg = 'NONE' },
            SnacksDashboardFooter = { fg = colors.blue, bg = 'NONE', style = { 'italic' } },
            SnacksDashboardDir = { fg = colors.text, bg = 'NONE' },
            SnacksDashboardFile = { fg = colors.text, bg = 'NONE' },
            SnacksDashboardTitle = { fg = colors.blue, bg = 'NONE', style = { 'bold' } },

            -- Snacks UI titles (Explorer, etc.)
            SnacksNotifierTitle = { bg = 'NONE' },
            SnacksNotifierBorder = { bg = 'NONE' },

            -- Noice command line colors
            NoiceCmdlinePopup = { fg = colors.peach, bg = 'NONE' },
            NoiceCmdlinePopupBorder = { fg = colors.peach, bg = 'NONE' },
            NoiceCmdlineIcon = { fg = colors.peach },
            NoiceCmdlinePrompt = { fg = colors.peach },

            -- Yank highlight
            YankHighlight = { bg = colors.peach, fg = colors.base },

            -- UFO fold highlights (transparent background)
            Folded = { bg = 'NONE' },
            FoldColumn = { bg = 'NONE' },
          }
        end,
      }
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
}
