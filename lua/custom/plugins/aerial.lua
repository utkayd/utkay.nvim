return {
  'stevearc/aerial.nvim',
  event = 'BufRead',
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-mini/mini.icons',
  },
  config = function()
    require('aerial').setup {
      attach_mode = 'global',
      backends = { 'lsp', 'treesitter', 'markdown', 'man' },
      show_guides = true,
      layout = {
        resize_to_content = false,
        win_opts = {
          winhl = 'Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB',
          signcolumn = 'yes',
          statuscolumn = ' ',
        },
        default_direction = 'prefer_left',
      },
      filter_kind = false,
      highlight_on_hover = true,
      autojump = true,
      close_on_select = true,
    }
    vim.keymap.set('n', '<leader>cs', '<cmd>AerialToggle<CR>')
  end,
}
