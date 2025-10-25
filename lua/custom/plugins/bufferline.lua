return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- Required for file icons
  },
  keys = {
    { '<S-h>', '<cmd>bprevious<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>bnext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>bprevious<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>bnext<cr>', desc = 'Next Buffer' },
    { '<A-h>', '<cmd>bprevious<cr>', desc = 'Move to previous buffer' },
    { '<A-l>', '<cmd>bnext<cr>', desc = 'Move to next buffer' },
  },
  config = function()
    require('bufferline').setup {
      highlights = {
        -- Set fill to transparent - the transparency function will handle the rest
        fill = { bg = '' },
      },
      options = {
        mode = 'buffers', -- set to "tabs" to only show tabpages instead
        themable = false, -- disable to prevent colorscheme from overriding transparency
        numbers = 'none',
        close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
        right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
        left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        indicator = {
          style = 'icon',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
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
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = '', -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
        sort_by = 'insert_after_current',
      },
    }

    -- Apply transparent backgrounds to all bufferline highlight groups
    local function apply_transparent_bufferline()
      -- Get all highlight groups that start with BufferLine
      local all_groups = vim.fn.getcompletion('BufferLine', 'highlight')

      -- Make all BufferLine groups have no background
      for _, hl_name in ipairs(all_groups) do
        local hl = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
        -- Only modify if it's not a link and has content
        if hl and next(hl) then
          -- Explicitly set bg to NONE to force transparency
          hl.bg = nil
          hl.ctermbg = nil
          vim.api.nvim_set_hl(0, hl_name, hl)
        end
      end

      -- Also make standard Vim tabline groups transparent
      local vim_tabline_groups = { 'TabLine', 'TabLineFill', 'TabLineSel' }
      for _, hl_name in ipairs(vim_tabline_groups) do
        local hl = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
        if hl then
          hl.bg = nil
          hl.ctermbg = nil
          vim.api.nvim_set_hl(0, hl_name, hl)
        end
      end

      -- Force redraw to apply changes
      vim.cmd('redraw')
    end

    -- Apply with delay to ensure colorscheme and bufferline have loaded
    vim.defer_fn(apply_transparent_bufferline, 100)

    -- Reapply after colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.defer_fn(apply_transparent_bufferline, 100)
      end,
    })
  end,
}
