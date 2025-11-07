return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-mini/mini.icons', -- for file icons
  },
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '<A-h>', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer left' },
    { '<A-l>', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer right' },
    { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle pin' },
  },
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',
        numbers = 'none',
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,
        indicator = {
          style = 'none',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        diagnostics = false,
        groups = {
          items = {
            require('bufferline.groups').builtin.pinned:with({ icon = '󰐃 ' }),
          },
        },
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = { '|', '|' },
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = false,
          delay = 200,
          reveal = { 'close' },
        },
        sort_by = 'insert_after_current',
      },
      highlights = {
        fill = {
          bg = 'NONE',
        },
        buffer_selected = {
          fg = '#8aadf4', -- catppuccin-macchiato blue
          bg = 'NONE',
          bold = false,
          italic = false,
        },
        buffer_visible = {
          fg = '#cad3f5', -- catppuccin-macchiato text
          bg = 'NONE',
          bold = false,
          italic = false,
        },
        background = {
          fg = '#cad3f5', -- catppuccin-macchiato text
          bg = 'NONE',
          bold = false,
          italic = false,
        },
      },
    }
  end,
}
-- vim: ts=2 sts=2 sw=2 et
