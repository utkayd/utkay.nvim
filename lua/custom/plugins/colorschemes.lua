return {
  { 'catppuccin/nvim' },
  { 'ellisonleao/gruvbox.nvim' },
  {
    'rebelot/kanagawa.nvim',
    init = function()
      require('kanagawa').setup {
        transparent = true,
      }
    end,
  },
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'EdenEast/nightfox.nvim' },
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000, -- Ensure it loads first
  },
}
