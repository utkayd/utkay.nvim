return {
  'mistricky/codesnap.nvim',
  tag = 'v2.0.0-beta.17',
  cmd = { 'CodeSnap', 'CodeSnapSave', 'CodeSnapASCII', 'CodeSnapHighlight', 'CodeSnapSaveHighlight' },
  opts = {
    snapshot_config = {
      code_config = {
        font_family = 'RobotoMono Nerd Font',
      },
      theme = 'candy',
      watermark = {
        content = 'Utkay.nvim',
      },
      background = {
        start = { x = 0, y = 0 },
        ['end'] = { x = 'max', y = 'max' },
        stops = {
          { position = 0, color = '#E85A84' }, -- red
          { position = 0.9, color = '#FAB387' }, -- orange2
        },
      },
    },
  },
}
