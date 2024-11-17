return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  lazy = false,
  config = function()
    require('refactoring').setup {
      vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
        require('refactoring').select_refactor()
      end),
      vim.keymap.set('n', '<leader>rp', function()
        require('refactoring').debug.printf { below = false }
      end),
    }
  end,
}
