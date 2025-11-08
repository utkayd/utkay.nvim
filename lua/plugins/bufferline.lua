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
            require('bufferline.groups').builtin.pinned:with { icon = '󰐃' },
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
        show_tab_indicators = false,
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
      highlights = function(config)
        local colors = {
          -- Get colors from existing highlight groups for resilience across colorschemes
          normal_fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).fg,
          comment_fg = vim.api.nvim_get_hl(0, { name = 'Comment' }).fg,
          blue_fg = '#8caaee', -- Custom blue color for selected buffer
        }

        return {
          fill = {
            bg = 'NONE',
          },
          buffer_selected = {
            fg = colors.blue_fg, -- Use blue color (Function highlight) for selected buffer
            bg = 'NONE',
            bold = false,
            italic = false,
          },
          buffer_visible = {
            fg = colors.normal_fg, -- Use normal text color
            bg = 'NONE',
            bold = false,
            italic = false,
          },
          background = {
            fg = colors.comment_fg, -- Use comment color for inactive buffers
            bg = 'NONE',
            bold = false,
            italic = false,
          },
          -- Separator highlights
          separator = {
            fg = colors.comment_fg,
            bg = 'NONE',
          },
          separator_selected = {
            fg = colors.blue_fg,
            bg = 'NONE',
          },
          separator_visible = {
            fg = colors.comment_fg,
            bg = 'NONE',
          },
          -- Tab highlights (for the weird bg after separator)
          tab = {
            fg = colors.comment_fg,
            bg = 'NONE',
          },
          tab_selected = {
            fg = colors.blue_fg,
            bg = 'NONE',
          },
          tab_close = {
            fg = colors.comment_fg,
            bg = 'NONE',
          },
          -- Close button highlights
          close_button = {
            fg = colors.comment_fg,
            bg = 'NONE',
          },
          close_button_visible = {
            fg = colors.normal_fg,
            bg = 'NONE',
          },
          close_button_selected = {
            fg = colors.blue_fg,
            bg = 'NONE',
          },
          -- Modified indicator
          modified = {
            fg = colors.comment_fg,
            bg = 'NONE',
          },
          modified_visible = {
            fg = colors.normal_fg,
            bg = 'NONE',
          },
          modified_selected = {
            fg = colors.blue_fg,
            bg = 'NONE',
          },
        }
      end,
    }
  end,
}
-- vim: ts=2 sts=2 sw=2 et
