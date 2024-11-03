return {
  'brenoprata10/nvim-highlight-colors',
  init = function()
    vim.opt.termguicolors = true
    require('nvim-highlight-colors').setup {}
  end,
}
