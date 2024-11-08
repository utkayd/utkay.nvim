return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {
      previewers = {
        builtin = {
          extensions = {
            -- neovim terminal only supports `viu` block output
            ['png'] = { 'viu' },
            ['jpg'] = { 'viu' },
          },
          -- When using 'ueberzug' we can also control the way images
          -- fill the preview area with ueberzug's image scaler, set to:
          --   false (no scaling), "crop", "distort", "fit_contain",
          --   "contain", "forced_cover", "cover"
          -- For more details see:
          -- https://github.com/seebye/ueberzug
        },
      },
    }
    require('fzf-lua').register_ui_select(function(_, items)
      local min_h, max_h = 0.15, 0.70
      local h = (#items + 4) / vim.o.lines
      if h < min_h then
        h = min_h
      elseif h > max_h then
        h = max_h
      end
      return { winopts = { height = h, width = 0.60, row = 0.40 } }
    end)
  end,
}
