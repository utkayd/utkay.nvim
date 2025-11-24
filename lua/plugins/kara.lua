return {
  {
    dir = '/Users/utkay/leisure/kara',
    lazy = true,
    config = function()
      require('kara').setup {
        on_highlights = function(highlights, colors)
          -- Override backgrounds to be transparent
          highlights.Normal = { fg = colors.fg, bg = 'NONE' }
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

          -- Fidget.nvim highlights (LSP progress notifications)
          highlights.FidgetTask = { fg = colors.fg, bg = 'NONE' }
          highlights.FidgetTitle = { fg = colors.blue, bg = 'NONE', bold = true }
          highlights.FidgetNormal = { bg = 'NONE' }
          highlights.FidgetBorder = { fg = colors.blue, bg = 'NONE' }

          -- Lazygit bright text (use a brighter color than default Normal)
          highlights.LazyGitText = { fg = '#ffffff' }  -- Pure white for lazygit text
        end,
      }
    end,
  },
}
