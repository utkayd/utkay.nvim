-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = 'YankHighlight', timeout = 200 }
  end,
})

-- Show diagnostic automatically when cursor hovers over diagnostic text
local diagnostic_hover_group = vim.api.nvim_create_augroup('diagnostic-float-on-hover', { clear = true })

vim.api.nvim_create_autocmd('CursorHold', {
  desc = 'Show diagnostics in floating window on hover',
  group = diagnostic_hover_group,
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor', header = '' })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
