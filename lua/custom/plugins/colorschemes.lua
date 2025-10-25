return {
  {
    'catppuccin/nvim',
    priority = 1000,
    opts = {},
    config = function()
      require('catppuccin').setup {
        transparent_background = false, -- Keep this false to preserve colors
        integrations = {
          bufferline = false, -- Disable bufferline integration to prevent color overrides
        },
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

            -- Current line highlight
            CursorLine = { bg = colors.surface0 },
            CursorLineNr = { fg = colors.yellow, bg = colors.surface0, style = { 'bold' } },
          }
        end,
      }
      vim.cmd.colorscheme 'catppuccin-macchiato'

      -- Configure MiniTabline with subtle backgrounds for buffer names
      -- Keep fill areas transparent
      vim.defer_fn(function()
        -- Groups that should have NO background (transparent)
        local transparent_groups = {
          'MiniTablineFill',
          'TabLineFill',
          'TabLine',
          'MiniTablineVisible',
          'MiniTablineHidden',
          'MiniTablineModifiedVisible',
          'MiniTablineModifiedHidden',
        }

        -- Groups that should have background (only current/selected buffer)
        -- Using Catppuccin Macchiato sapphire color for vibrant selection
        local current_buffer_groups = {
          { name = 'MiniTablineCurrent', bg = 'NONE' },
          { name = 'MiniTablineModifiedCurrent', bg = 'NONE' },
        }

        -- Make transparent groups have no background
        for _, hl_name in ipairs(transparent_groups) do
          local hl = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
          if hl and next(hl) then
            hl.bg = nil
            hl.ctermbg = nil
            vim.api.nvim_set_hl(0, hl_name, hl)
          end
        end

        -- Add background only to current buffer and remove underline/italic
        for _, group in ipairs(current_buffer_groups) do
          local hl = vim.api.nvim_get_hl(0, { name = group.name, link = false })
          if hl and next(hl) then
            hl.bg = group.bg
            hl.fg = '#181926' -- Dark text for readability on vibrant background (Catppuccin base)
            hl.italic = false
            hl.underline = false
            vim.api.nvim_set_hl(0, group.name, hl)
          end
        end
      end, 200)
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
