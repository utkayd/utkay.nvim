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
          highlights.SnacksDashboardNormal = { fg = colors.snow_storm.origin, bg = 'NONE' }
          highlights.SnacksDashboardHeader = { fg = colors.aurora.yellow, bg = 'NONE', bold = true }
          highlights.SnacksDashboardIcon = { fg = colors.aurora.yellow, bg = 'NONE' }
          highlights.SnacksDashboardDesc = { fg = colors.snow_storm.origin, bg = 'NONE' }
          highlights.SnacksDashboardKey = { fg = colors.aurora.yellow, bg = 'NONE' }
          highlights.SnacksDashboardFooter = { fg = colors.aurora.yellow, bg = 'NONE', italic = true }
          highlights.SnacksDashboardDir = { fg = colors.snow_storm.origin, bg = 'NONE' }
          highlights.SnacksDashboardFile = { fg = colors.aurora.yellow, bg = 'NONE' }
          highlights.SnacksDashboardTitle = { fg = colors.aurora.yellow, bg = 'NONE', bold = true }

          -- Fidget.nvim highlights (LSP progress notifications)
          highlights.FidgetTask = { fg = colors.snow_storm.origin, bg = 'NONE' }
          highlights.FidgetTitle = { fg = colors.frost.ice, bg = 'NONE', bold = true }
          highlights.FidgetNormal = { bg = 'NONE' }
          highlights.FidgetBorder = { fg = colors.frost.artic_water, bg = 'NONE' }

          -- UFO fold highlights (visible background for folds)
          highlights.Folded = { fg = colors.snow_storm.origin, bg = colors.polar_night.brightest }
          highlights.FoldColumn = { fg = colors.polar_night.brightest, bg = 'NONE' }
          highlights.UfoFoldedBg = { bg = colors.polar_night.brightest }
          highlights.UfoFoldedFg = { fg = colors.snow_storm.origin }
          highlights.UfoCursorFoldedLine = { fg = colors.frost.ice, bg = colors.polar_night.light, bold = true }

          -- ErrorMsg is what Snacks uses for error notifications
          highlights.ErrorMsg = { fg = colors.aurora.red, bg = 'NONE', bold = true, italic = true }

          -- Yank highlight (similar to catppuccin peach)
          highlights.YankHighlight = { bg = colors.aurora.orange, fg = colors.polar_night.origin }
        end,
      }
    end,
  },
}
