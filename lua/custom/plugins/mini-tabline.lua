return {
  'nvim-mini/mini.tabline',
  version = false,
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
    require('mini.tabline').setup {
      show_icons = true,
      tabpage_section = 'right',
      format = function(buf_id, label)
        -- Get file icon from nvim-web-devicons
        local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
        local icon = ''
        if devicons_ok then
          local buf_name = vim.api.nvim_buf_get_name(buf_id)
          local file_name = vim.fn.fnamemodify(buf_name, ':t')
          local extension = vim.fn.fnamemodify(buf_name, ':e')
          local icon_result, _ = devicons.get_icon(file_name, extension, { default = true })
          if icon_result then
            icon = icon_result .. ' '
          end
        end

        -- Only add separator if not the first buffer
        local bufs = vim.fn.getbufinfo { buflisted = 1 }
        return ' ' .. icon .. label .. ' '
      end,
    }

    -- Set all MiniTabline highlight groups with subtle backgrounds
    -- Keep TabLineFill transparent so background only shows behind buffer names
    local function apply_transparent_tabline()
      -- Groups that should have NO background (transparent)
      local transparent_groups = {
        'MiniTablineFill',
        'TabLineFill',
        'TabLine',
        'MiniTablineVisible', -- Unselected visible buffers
        'MiniTablineHidden', -- Unselected hidden buffers
        'MiniTablineModifiedVisible', -- Unselected modified visible
        'MiniTablineModifiedHidden', -- Unselected modified hidden
      }

      -- Groups that should have background (only current/selected buffer)
      -- Using Catppuccin Macchiato sapphire color for vibrant selection
      local current_buffer_groups = {
        { name = 'MiniTablineCurrent', bg = '#c6a0f6' },
        { name = 'MiniTablineModifiedCurrent', bg = '#8aadf4' },
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
    end

    -- Apply with longer delay to ensure colorscheme has loaded
    vim.defer_fn(apply_transparent_tabline, 300)

    -- Reapply after colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.defer_fn(apply_transparent_tabline, 100)
      end,
    })

    -- Also reapply when mini.tabline sets up its highlights
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniTablineSetup',
      callback = function()
        vim.defer_fn(apply_transparent_tabline, 50)
      end,
    })

    -- Create a command to manually apply transparency and debug
    vim.api.nvim_create_user_command('TransparentTabline', function()
      print '=== Before applying transparency ==='
      local test_groups = { 'MiniTablineCurrent', 'MiniTablineFill', 'TabLine', 'TabLineFill' }
      for _, name in ipairs(test_groups) do
        local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
        print(name .. ': ' .. vim.inspect(hl))
      end

      apply_transparent_tabline()

      print '=== After applying transparency ==='
      for _, name in ipairs(test_groups) do
        local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
        print(name .. ': ' .. vim.inspect(hl))
      end
    end, {})
  end,
}
