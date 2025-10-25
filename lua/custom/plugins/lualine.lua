return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  config = function()
    local function empty()
      return [[ ]]
    end

    -- Color variations from base #363A4F for visual distinction
    local colors = {
      darkest = '#2A2D3D', -- 20% darker
      darker = '#30344A', -- 10% darker
      base = '#363A4F', -- base color
      lighter1 = '#42465D', -- 20% lighter
      lighter2 = '#4E536B', -- 40% lighter
      lighter3 = '#5A6079', -- 60% lighter
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = ' ', right = '' } },
        },
        lualine_b = {
          { 'branch', color = { bg = colors.darkest }, separator = { left = '', right = '' } },
          { 'diff', color = { bg = colors.darker }, separator = { left = '', right = '' } },
          { 'diagnostics', color = { bg = colors.base }, separator = { left = '', right = '' } },
          { 'filename', color = { bg = colors.lighter1, fg = '#ebdbb2' }, separator = { left = '' } },
          { empty, color = { bg = '#1E2030' }, separator = { left = '' } },
        },
        lualine_c = {},
        lualine_x = {
          {
            color = { bg = colors.lighter2 },
            separator = { left = '', right = '' },
            function()
              return require('noice').api.status.command.get()
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.command.has()
            end,
          },
          {
            function()
              return require('noice').api.status.mode.get()
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.mode.has()
            end,
            color = { bg = colors.lighter1 },
          },
          {
            function()
              local lazy_status = require 'lazy.status'
              return lazy_status.updates()
            end,
            cond = function()
              local lazy_status = require 'lazy.status'
              return lazy_status.has_updates()
            end,
            color = { bg = colors.base },
          },
          { 'filetype', color = { bg = colors.darker }, separator = { left = '' } },
        },
        lualine_y = {
          {
            function()
              return require('vectorcode.integrations').lualine({})[1]()
            end,
            cond = function()
              if package.loaded['vectorcode'] == nil then
                return false
              else
                return require('vectorcode.integrations').lualine({}).cond()
              end
            end,
            color = { bg = colors.lighter1 },
          },
        },
        lualine_z = {
          {
            'location',
            separator = { left = '', right = ' ' },
            color = { bg = '#89b482' },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
