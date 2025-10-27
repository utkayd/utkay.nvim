return {
  'nvim-tree/nvim-web-devicons',
  config = function()
    -- Get catppuccin colors for theme consistency
    local colors = require('catppuccin.palettes').get_palette 'macchiato'

    require('nvim-web-devicons').setup {
      -- globally enable different highlight colors per icon (default to true)
      color_icons = true,
      -- globally enable default icons (default to false)
      default = true,
      -- globally enable "strict" selection of icons - icon will be looked up in
      -- different tables, first by filename, then by extension
      strict = true,
      -- override or add new icons
      override = {
        -- Unity .meta files (uses normal text color)
        meta = {
          icon = '󰚯', -- Unity icon (nf-md-unity)
          color = colors.text,
          cterm_color = '252',
          name = 'UnityMeta',
        },
        -- Unity .asset files (uses theme's peach color)
        asset = {
          icon = '󰚯', -- Unity icon (nf-md-unity)
          color = colors.peach,
          cterm_color = '216',
          name = 'UnityAsset',
        },
        -- Unity .lighting files
        lighting = {
          icon = '󱩎', -- Light bulb icon
          color = colors.yellow,
          cterm_color = '226',
          name = 'UnityLighting',
        },
        -- Unity .prefab files
        prefab = {
          icon = '󰚯', -- Unity cube icon
          color = colors.blue,
          cterm_color = '111',
          name = 'UnityPrefab',
        },
        unity = {
          icon = '󰚯', -- Unity cube icon
          color = colors.yellow,
          cterm_color = '111',
          name = 'UnityScene',
        },
      },
      -- override or add icons by filename
      override_by_filename = {
        ['.meta'] = {
          icon = '󰚯',
          color = colors.text,
          cterm_color = '252',
          name = 'UnityMeta',
        },
        ['.asset'] = {
          icon = '󰚯',
          color = colors.peach,
          cterm_color = '216',
          name = 'UnityAsset',
        },
        ['.lighting'] = {
          icon = '󱩎',
          color = colors.yellow,
          cterm_color = '226',
          name = 'UnityLighting',
        },
        ['.prefab'] = {
          icon = '󰚯',
          color = colors.blue,
          cterm_color = '111',
          name = 'UnityPrefab',
        },
        ['.unity'] = {
          icon = '󰚯',
          color = colors.yellow,
          cterm_color = '111',
          name = 'UnityScene',
        },
      },
      -- override or add icons by file extension
      override_by_extension = {
        ['meta'] = {
          icon = '󰚯', -- Unity icon (nf-md-unity)
          color = colors.text, -- Normal text color
          cterm_color = '252',
          name = 'UnityMeta',
        },
        ['asset'] = {
          icon = '󰚯', -- Unity icon (nf-md-unity)
          color = colors.peach, -- Theme's peach color
          cterm_color = '216',
          name = 'UnityAsset',
        },
        ['lighting'] = {
          icon = '󱩎', -- Light bulb icon
          color = colors.yellow, -- Yellow for lighting
          cterm_color = '226',
          name = 'UnityLighting',
        },
        ['prefab'] = {
          icon = '󰚯', -- Unity cube icon
          color = colors.blue, -- Blue for prefabs
          cterm_color = '111',
          name = 'UnityPrefab',
        },
        ['unity'] = {
          icon = '󰚯', -- Unity icon for scene files
          color = colors.yellow, -- Yellow for scenes
          cterm_color = '111',
          name = 'UnityScene',
        },
        ['cs'] = {
          icon = '󰌛', -- C# icon
          color = '#0088d1', -- Blue matching lazygit C# color
          cterm_color = '111',
          name = 'cs',
        },
      },
    }
  end,
}
