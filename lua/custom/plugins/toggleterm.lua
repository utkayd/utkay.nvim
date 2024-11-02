return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = 15, -- Adjust size as needed
      open_mapping = [[<C-/>]], -- Updated keybinding to toggle the terminal
      direction = 'horizontal', -- Open terminal at the bottom
      shading_factor = 2, -- Adjust shading for better visibility
      start_in_insert = true, -- Start in insert mode
      persist_size = true, -- Remember the terminal size
      close_on_exit = true, -- Close the terminal when the process exits
      shell = vim.o.shell, -- Use the default shell
    }
  end,
}
