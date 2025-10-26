return {}
--[[ DISABLED - Switched to barbar.nvim
return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- Required for file icons
  },
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>bprevious<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>bnext<cr>', desc = 'Next Buffer' },
    { '<A-h>', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer left' },
    { '<A-l>', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer right' },
  },
  config = function()
    -- Get catppuccin colors
    local colors = require('catppuccin.palettes').get_palette 'macchiato'

    require('bufferline').setup {
      highlights = {
        -- Set fill to transparent - the transparency function will handle the rest
        fill = { bg = '' },
        -- All buffer states - keep styling identical, only change color
        background = {
          bold = false,
          italic = false,
          underline = false,
        },
        buffer = {
          bold = false,
          italic = false,
          underline = false,
        },
        buffer_visible = {
          bold = false,
          italic = false,
          underline = false,
        },
        buffer_selected = {
          fg = colors.blue,
          bold = false,
          italic = false,
          underline = false,
        },
        -- All selected buffer components should have no bold/italic/underline
        numbers_selected = {
          fg = colors.blue,
          bold = false,
          italic = false,
          underline = false,
        },
        close_button_selected = {
          fg = colors.blue,
          bold = false,
          italic = false,
          underline = false,
        },
        duplicate_selected = {
          fg = colors.blue,
          bold = false,
          italic = false,
          underline = false,
        },
        -- Icons for all states
        icon = {
          bold = false,
          italic = false,
          underline = false,
        },
        icon_selected = {
          bold = false,
          italic = false,
          underline = false,
        },
        icon_visible = {
          bold = false,
          italic = false,
          underline = false,
        },
        -- Diagnostics for selected buffer
        diagnostic_selected = {
          fg = colors.blue,
          bold = false,
          italic = false,
          underline = false,
        },
        error_selected = {
          bold = false,
          italic = false,
          underline = false,
        },
        warning_selected = {
          bold = false,
          italic = false,
          underline = false,
        },
        info_selected = {
          bold = false,
          italic = false,
          underline = false,
        },
        hint_selected = {
          bold = false,
          italic = false,
          underline = false,
        },
        -- Modified buffers - catppuccin purple
        modified = {
          fg = colors.mauve,
          bold = false,
          italic = false,
        },
        modified_selected = {
          fg = colors.mauve,
          bold = false,
          italic = false,
        },
        modified_visible = {
          fg = colors.mauve,
          bold = false,
          italic = false,
        },
        -- Separators - keep EXACTLY consistent appearance across all states
        separator = {
          fg = colors.overlay0,
          bg = '',
          bold = false,
          italic = false,
          underline = false,
        },
        separator_selected = {
          fg = colors.overlay0,
          bg = '',
          bold = false,
          italic = false,
          underline = false,
        },
        separator_visible = {
          fg = colors.overlay0,
          bg = '',
          bold = false,
          italic = false,
          underline = false,
        },
        -- Indicator - keep consistent too
        indicator_selected = {
          fg = colors.blue,
          bold = false,
        },
        indicator_visible = {
          fg = colors.overlay0,
          bold = false,
        },
      },
      options = {
        mode = 'buffers', -- set to "tabs" to only show tabpages instead
        themable = false, -- disable to prevent colorscheme from overriding transparency
        numbers = 'none',
        max_name_length = 999,
        tab_size = 22,
        close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
        right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
        left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        indicator = {
          style = 'none',
        },
        buffer_close_icon = '',
        modified_icon = '',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        diagnostics = false,
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            text_align = 'left',
            separator = true,
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = 'thin',
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
        sort_by = 'insert_after_current',
      },
    }
  end,
}
--]]
