return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  keys = {
    { '<S-h>', '<cmd>BufferPrevious<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferNext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>BufferPrevious<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferNext<cr>', desc = 'Next Buffer' },
    { '<A-h>', '<cmd>BufferMovePrevious<cr>', desc = 'Move buffer left' },
    { '<A-l>', '<cmd>BufferMoveNext<cr>', desc = 'Move buffer right' },
  },
  opts = {
    -- Enable/disable animations
    animation = true,

    -- Enable/disable auto-hiding the tab bar when there is a single buffer
    auto_hide = false,

    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = false,

    -- Enables/disable clickable tabs
    clickable = true,

    -- Excludes buffers from the tabline
    exclude_ft = {},
    exclude_name = {},

    -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
    focus_on_close = 'previous',

    -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
    hide = { extensions = false, inactive = false },

    -- Disable highlighting alternate buffers
    highlight_alternate = false,

    -- Disable highlighting file icons in inactive buffers
    highlight_inactive_file_icons = false,

    -- Enable highlighting visible buffers
    highlight_visible = true,

    icons = {
      buffer_index = false,
      buffer_number = false,
      button = '',
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = false },
        [vim.diagnostic.severity.WARN] = { enabled = false },
        [vim.diagnostic.severity.INFO] = { enabled = false },
        [vim.diagnostic.severity.HINT] = { enabled = false },
      },
      gitsigns = {
        added = { enabled = false },
        changed = { enabled = false },
        deleted = { enabled = false },
      },
      filetype = {
        custom_colors = false,
        enabled = true,
      },
      separator = { left = '|', right = '' },
      separator_at_end = false,
      modified = { button = '' },
      pinned = { button = '', filename = true },
      alternate = {
        filetype = { enabled = false },
        button = '',
      },
      current = {
        buffer_index = false,
        button = '',
      },
      inactive = {
        button = '',
      },
      visible = {
        modified = { buffer_number = false },
        button = '',
      },
    },

    -- If true, new buffers will be inserted at the start/end of the list.
    insert_at_end = false,
    insert_at_start = false,

    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,

    -- Sets the minimum padding width with which to surround each tab
    minimum_padding = 1,

    -- Sets the maximum buffer name length.
    maximum_length = 999,

    -- Sets the minimum buffer name length.
    minimum_length = 0,

    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case of letters shortage,
    -- assign letters in a sequence (asdfjkl;ghnmxcvbziowerutyqpZXCVBNMASDFGHJKLQWERTYUIOP)
    semantic_letters = true,

    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustment
    -- for other layouts.
    letters = 'asdfjkl;ghnmxcvbziowerutyqpZXCVBNMASDFGHJKLQWERTYUIOP',

    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    no_name_title = nil,

    -- Disable sidebar offset
    sidebar_filetypes = {},
  },
  config = function(_, opts)
    require('barbar').setup(opts)

    -- Get catppuccin colors
    local colors = require('catppuccin.palettes').get_palette 'macchiato'

    -- Apply custom highlights for barbar with transparent backgrounds
    local function apply_barbar_highlights()
      -- Transparent backgrounds for all groups, NO BOLD except targets
      vim.api.nvim_set_hl(0, 'BufferCurrent', { fg = colors.blue, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferCurrentIcon', { fg = colors.blue, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferCurrentIndex', { fg = colors.blue, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = colors.mauve, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = colors.blue, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferCurrentTarget', { fg = colors.red, bg = 'NONE', bold = false, italic = false, underline = false })

      vim.api.nvim_set_hl(0, 'BufferVisible', { fg = colors.text, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferVisibleIcon', { fg = colors.text, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferVisibleIndex', { fg = colors.text, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferVisibleMod', { fg = colors.mauve, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferVisibleSign', { fg = colors.text, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferVisibleTarget', { fg = colors.red, bg = 'NONE', bold = false, italic = false, underline = false })

      vim.api.nvim_set_hl(0, 'BufferInactive', { fg = colors.subtext0, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferInactiveIcon', { fg = colors.subtext0, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferInactiveIndex', { fg = colors.subtext0, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferInactiveMod', { fg = colors.mauve, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferInactiveSign', { fg = colors.subtext0, bg = 'NONE', bold = false, italic = false, underline = false })
      vim.api.nvim_set_hl(0, 'BufferInactiveTarget', { fg = colors.red, bg = 'NONE', bold = false, italic = false, underline = false })

      -- Separators - keep identical across all states, NO BOLD, force exact styling
      local separator_hl = { fg = colors.overlay0, bg = 'NONE', bold = false, italic = false, underline = false, nocombine = true }
      vim.api.nvim_set_hl(0, 'BufferCurrentSeparator', separator_hl)
      vim.api.nvim_set_hl(0, 'BufferVisibleSeparator', separator_hl)
      vim.api.nvim_set_hl(0, 'BufferInactiveSeparator', separator_hl)
      vim.api.nvim_set_hl(0, 'BufferAlternateSeparator', separator_hl)
      vim.api.nvim_set_hl(0, 'BufferDefaultCurrentSeparator', separator_hl)
      vim.api.nvim_set_hl(0, 'BufferDefaultVisibleSeparator', separator_hl)
      vim.api.nvim_set_hl(0, 'BufferDefaultInactiveSeparator', separator_hl)
      vim.api.nvim_set_hl(0, 'BufferDefaultAlternateSeparator', separator_hl)

      -- Also try to override any other separator-like groups
      vim.api.nvim_set_hl(0, 'TabLineSel', separator_hl)

      -- Tabline fill
      vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'BufferTabpages', { fg = colors.text, bg = 'NONE', bold = true })

      -- Offset (for NvimTree, etc.)
      vim.api.nvim_set_hl(0, 'BufferOffset', { fg = colors.text, bg = 'NONE', bold = false, italic = false })
    end

    -- Apply highlights with delay to override defaults
    vim.defer_fn(apply_barbar_highlights, 100)

    -- Reapply on colorscheme change
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.defer_fn(apply_barbar_highlights, 100)
      end,
    })

    -- Also reapply after any buffer enter to catch late-loading highlights
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      callback = function()
        vim.defer_fn(apply_barbar_highlights, 200)
      end,
    })
  end,
}
