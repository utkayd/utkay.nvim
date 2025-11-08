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

            -- -- Make backgrounds transparent (inherit from terminal)
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

            -- -- Snacks UI titles (Explorer, etc.)
            -- SnacksNotifierTitle = { bg = 'NONE' },
            -- SnacksNotifierBorder = { bg = 'NONE' },

            -- Noice command line colors
            NoiceCmdlinePopup = { fg = colors.peach, bg = 'NONE' },
            NoiceCmdlinePopupBorder = { fg = colors.peach, bg = 'NONE' },
            NoiceCmdlineIcon = { fg = colors.peach },
            NoiceCmdlinePrompt = { fg = colors.peach },

            -- Yank highlight
            YankHighlight = { bg = colors.peach, fg = colors.base },

            -- Fidget.nvim highlights (LSP progress notifications)
            FidgetTask = { fg = colors.text, bg = 'NONE' },
            FidgetTitle = { fg = colors.blue, bg = 'NONE', style = { 'bold' } },
            FidgetNormal = { bg = 'NONE' },
            FidgetBorder = { fg = colors.blue, bg = 'NONE' },

            -- UFO fold highlights (visible background for folds)
            Folded = { fg = colors.overlay2, bg = colors.surface0 },
            FoldColumn = { fg = colors.overlay0, bg = 'NONE' },
            UfoFoldedBg = { bg = colors.surface0 },
            UfoFoldedFg = { fg = colors.overlay2 },
            UfoCursorFoldedLine = { fg = colors.text, bg = colors.surface1, style = { 'bold' } },
          }
        end,
      }
    end,
  },
  {
    'gbprod/nord.nvim',
    config = function()
      require('nord').setup {
        transparent = false, -- Keep false to use nord colors properly
        on_highlights = function(highlights, colors)
          -- Override backgrounds to be transparent
          highlights.Normal = { bg = 'NONE' }
          highlights.NormalNC = { bg = 'NONE' }
          highlights.NormalFloat = { bg = 'NONE' }
          highlights.FloatBorder = { bg = 'NONE' }
          highlights.FloatTitle = { bg = 'NONE' }
          highlights.Pmenu = { bg = 'NONE' }
          highlights.SignColumn = { bg = 'NONE' }
          highlights.StatusLine = { bg = 'NONE' }
          highlights.TabLine = { bg = 'NONE' }
          highlights.TabLineFill = { bg = 'NONE' }
          highlights.TabLineSel = { bg = 'NONE' }

          -- Snacks Dashboard highlights
          highlights.SnacksDashboardNormal = { fg = colors.nord4, bg = 'NONE' }
          highlights.SnacksDashboardHeader = { fg = colors.nord8, bg = 'NONE', bold = true }
          highlights.SnacksDashboardIcon = { fg = colors.nord8, bg = 'NONE' }
          highlights.SnacksDashboardDesc = { fg = colors.nord4, bg = 'NONE' }
          highlights.SnacksDashboardKey = { fg = colors.nord7, bg = 'NONE' }
          highlights.SnacksDashboardFooter = { fg = colors.nord8, bg = 'NONE', italic = true }
          highlights.SnacksDashboardDir = { fg = colors.nord4, bg = 'NONE' }
          highlights.SnacksDashboardFile = { fg = colors.nord4, bg = 'NONE' }
          highlights.SnacksDashboardTitle = { fg = colors.nord8, bg = 'NONE', bold = true }

          -- Fidget.nvim highlights (LSP progress notifications)
          highlights.FidgetTask = { fg = colors.nord4, bg = 'NONE' }
          highlights.FidgetTitle = { fg = colors.nord8, bg = 'NONE', bold = true }
          highlights.FidgetNormal = { bg = 'NONE' }
          highlights.FidgetBorder = { fg = colors.nord9, bg = 'NONE' }

          -- UFO fold highlights (visible background for folds)
          highlights.Folded = { fg = '#D8DEE9', bg = '#4C566A' } -- nord4 text on nord3 bg
          highlights.FoldColumn = { fg = '#4C566A', bg = 'NONE' }
          highlights.UfoFoldedBg = { bg = '#4C566A' } -- nord3
          highlights.UfoFoldedFg = { fg = '#D8DEE9' } -- nord4
          highlights.UfoCursorFoldedLine = { fg = '#88C0D0', bg = '#616E88', bold = true } -- nord8 on light gray
        end,
      }
    end,
  },
}
