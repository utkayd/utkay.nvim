return {
  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplwce [)] [']
      require('mini.surround').setup()

      -- Autopairs - automatically insert closing brackets, quotes, etc.
      require('mini.pairs').setup()

      -- File icons (replaces nvim-web-devicons)
      local icons = require 'mini.icons'
      icons.setup {
        -- Extension-based icons
        extension = {
          -- Unity file extensions
          meta = { glyph = '󰚯', hl = 'MiniIconsUnityMeta' },
          asset = { glyph = '󰚯', hl = 'MiniIconsUnityAsset' },
          lighting = { glyph = '󱩎', hl = 'MiniIconsUnityLighting' },
          prefab = { glyph = '󰚯', hl = 'MiniIconsUnityPrefab' },
          unity = { glyph = '󰚯', hl = 'MiniIconsUnityScene' },
          -- C# custom icon
          cs = { glyph = '󰌛', hl = 'MiniIconsCSharp' },
        },
        -- Filename-based icons (for dotfiles like .meta, .asset, etc.)
        file = {
          ['.meta'] = { glyph = '󰚯', hl = 'MiniIconsUnityMeta' },
          ['.asset'] = { glyph = '󰚯', hl = 'MiniIconsUnityAsset' },
          ['.lighting'] = { glyph = '󱩎', hl = 'MiniIconsUnityLighting' },
          ['.prefab'] = { glyph = '󰚯', hl = 'MiniIconsUnityPrefab' },
          ['.unity'] = { glyph = '󰚯', hl = 'MiniIconsUnityScene' },
        },
        style = 'glyph', -- Use only glyphs (icons)
      }

      -- Mock nvim-web-devicons for plugins that expect it (like barbar)
      icons.mock_nvim_web_devicons()

      -- Define custom highlight groups for Unity icons using catppuccin colors
      local colors = require('catppuccin.palettes').get_palette 'macchiato'
      vim.api.nvim_set_hl(0, 'MiniIconsUnityMeta', { fg = colors.text })
      vim.api.nvim_set_hl(0, 'MiniIconsUnityAsset', { fg = colors.peach })
      vim.api.nvim_set_hl(0, 'MiniIconsUnityLighting', { fg = colors.yellow })
      vim.api.nvim_set_hl(0, 'MiniIconsUnityPrefab', { fg = colors.blue })
      vim.api.nvim_set_hl(0, 'MiniIconsUnityScene', { fg = colors.yellow })
      vim.api.nvim_set_hl(0, 'MiniIconsCSharp', { fg = '#0088d1' })

      -- Highlight patterns (TODO comments, color codes, etc.)
      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = {
          -- Highlight TODO, FIXME, HACK, NOTE, etc. in comments
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (#rrggbb, #rgb)
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }

      -- Simple wnd easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
