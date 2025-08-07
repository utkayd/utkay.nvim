return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
  },
  opts = {
    options = {
      config = function(_, opts)
        vim.opt.termguicolors = true
        require('bufferline').setup(opts)
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
          callback = function()
            vim.schedule(function()
              pcall(vim.cmd, 'BufferLineRefresh') -- Refresh bufferline explicitly
            end)
          end,
        })
      end,
      close_command = function(n)
        require('snacks.bufdelete').delete(n)
      end, -- Use 'bufdelete' instead of LazyVim's custom command
      right_mouse_command = function(n)
        require('snacks.bufdelete').delete(n)
      end, -- Same here
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      separator_style = 'slant',
      diagnostics_indicator = function(count, level, diagnostics_dict)
        local symbols = { error = '', warning = '', info = '' } -- Replace icons if needed
        local result = {}
        for key, value in pairs(diagnostics_dict) do
          if symbols[key] then
            table.insert(result, symbols[key] .. value)
          end
        end
        return table.concat(result, ' ')
      end,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
      get_element_icon = function(buffer)
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(buffer.filetype)
        return icon or '', hl -- Use default icons if none found
      end,
    },
    highlights = {
      background = {
        bg = '#292929', -- Foreground color (the separator character itself)
      },
      separator = {
        bg = '#292929', -- Foreground color (the separator character itself)
        fg = '#1F1F28', -- Background color behind the separator
      },
      separator_selected = {
        bg = '#454545', -- Different color for active separator
        fg = '#1F1F28', -- Background for active separator
      },
      separator_visible = {
        bg = '#292929', -- Color for visible separator
        fg = '#1F1F28', -- Background for visible separator
      },
      fill = {
        bg = '#1F1F28',
      },
      buffer_visible = {
        bg = '#292929',
      },
      buffer_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      numbers = {
        bg = '#292929',
      },
      numbers_visible = {
        bg = '#292929',
      },
      numbers_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      diagnostic = {
        bg = '#292929',
      },
      diagnostic_visible = {
        bg = '#292929',
      },
      diagnostic_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      hint = {
        bg = '#292929',
      },
      hint_visible = {
        bg = '#292929',
      },
      hint_selected = {
        bg = '#454545',
      },
      hint_diagnostic = {
        bg = '#292929',
      },
      hint_diagnostic_visible = {
        bg = '#292929',
      },
      hint_diagnostic_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      info = {
        bg = '#292929',
      },
      info_visible = {
        bg = '#292929',
      },
      info_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      info_diagnostic = {
        bg = '#292929',
      },
      info_diagnostic_visible = {
        bg = '#292929',
      },
      info_diagnostic_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      warning = {
        bg = '#292929',
      },
      warning_visible = {
        bg = '#292929',
      },
      warning_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      warning_diagnostic = {
        bg = '#292929',
      },
      warning_diagnostic_visible = {
        bg = '#292929',
      },
      warning_diagnostic_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      error = {
        bg = '#292929',
      },
      error_visible = {
        bg = '#292929',
      },
      error_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      error_diagnostic = {
        bg = '#292929',
      },
      error_diagnostic_visible = {
        bg = '#292929',
      },
      error_diagnostic_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      modified = {
        bg = '#292929',
      },
      modified_visible = {
        bg = '#292929',
      },
      modified_selected = {
        bg = '#454545',
      },
      close_button = {
        bg = '#292929',
      },
      close_button_visible = {
        bg = '#292929',
      },
      close_button_selected = {
        bg = '#454545',
      },
      indicator_visible = {
        bg = '#454545',
      },
      indicator_selected = {
        bg = '#454545',
      },
      pick_selected = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      pick_visible = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      pick = {
        bg = '#454545',
        bold = true,
        italic = false,
      },
      offset_separator = {
        bg = '#454545',
      },
      trunc_marker = {
        bg = '#454545',
      },
      duplicate_selected = {
        bg = '#454545',
        italic = false,
      },
      duplicate_visible = {
        bg = '#292929',
        italic = false,
      },
      duplicate = {
        bg = '#292929',
        italic = false,
      },
    },
  },
}
