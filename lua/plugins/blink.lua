return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = {
      -- Load VSCode-style snippets from your custom snippets directory
      paths = { vim.fn.stdpath 'config' .. '/snippets' },
    },
    keymap = { preset = 'enter', ['<C-k>'] = { 'select_prev', 'fallback' }, ['<C-j>'] = { 'select_next', 'fallback' } },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    cmdline = {
      keymap = { preset = 'cmdline' },
      completion = { menu = { auto_show = false } },
    },
    completion = {
      ghost_text = { enabled = true },
      menu = {
        border = 'rounded',
        winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
      },
      documentation = {
        auto_show = true,
        window = {
          border = 'rounded',
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:Visual,Search:None',
        },
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
  config = function(_, opts)
    require('blink.cmp').setup(opts)

    -- Set transparent backgrounds for blink windows
    vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'FloatBorder' })
    vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { link = 'PmenuSel' })
    vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { link = 'FloatBorder' })
  end,
}
