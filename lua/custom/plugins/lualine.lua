return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  config = function()
    local function empty()
      return [[ ]]
    end
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
          { 'branch', color = { bg = '#404040' }, separator = { left = '', right = '' } },
          { 'diff', color = { bg = '#505050' }, separator = { left = '', right = '' } },
          { 'diagnostics', color = { bg = '#606060' }, separator = { left = '', right = '' } },
          { 'filename', color = { bg = '#707070', fg = '#ebdbb2' }, separator = { left = '' } },
          { empty, color = { bg = '#2A2A37' }, separator = { left = '' } },
        },
        lualine_c = {},
        lualine_x = {
          {
            color = { bg = '#606060' },
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
            color = { fg = '#C678DD' },
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
            color = { fg = '#E5C07B' },
          },
          { 'filetype', color = { bg = '#404040' }, separator = { left = '' } },
        },
        lualine_y = {
          {
            function()
              return require('vectorcode.integrations').lualine(opts)[1]()
            end,
            cond = function()
              if package.loaded['vectorcode'] == nil then
                return false
              else
                return require('vectorcode.integrations').lualine(opts).cond()
              end
            end,
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
