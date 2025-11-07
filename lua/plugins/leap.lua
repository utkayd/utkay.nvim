return {
  'ggandor/leap.nvim',
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 't', '<Plug>(leap)')
  end,
}
