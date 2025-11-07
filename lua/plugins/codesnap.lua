return {
  'mistricky/codesnap.nvim',
  build = 'make',
  config = function()
    require('codesnap').setup {
      code_font_family = 'CommitMono Nerd Font',
      has_breadcrumbs = true,
      has_line_number = true,
      watermark = 'Utkay.nvim',
    }
  end,
}
