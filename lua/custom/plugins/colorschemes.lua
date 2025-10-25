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
            CursorLineNr = { fg = colors.yellow, style = { 'bold' } },

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
          }
        end,
      }
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
  { 'ellisonleao/gruvbox.nvim' },
  {
    'rebelot/kanagawa.nvim',
    init = function()
      require('kanagawa').setup {
        transparent = true,
      }
    end,
  },
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'EdenEast/nightfox.nvim' },
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000, -- Ensure it loads first
  },
}
