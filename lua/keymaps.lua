-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "use h to move!!"<cr>')
vim.keymap.set('n', '<right>', '<cmd>echo "use l to move!!"<cr>')
vim.keymap.set('n', '<up>', '<cmd>echo "use k to move!!"<cr>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true, silent = true })
vim.keymap.set('v', 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'c', '"_c', { noremap = true, silent = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true, silent = true })
vim.keymap.set('v', 'c', '"_c', { noremap = true, silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

--Save with Control+s
vim.keymap.set('n', '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })
vim.keymap.set('x', '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })
vim.keymap.set('i', '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })
vim.keymap.set('s', '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

--Quit with leader qq
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

--Select All Text
vim.keymap.set('n', 'vig', 'ggVG', { desc = 'Select All Text' })
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<Cr>', { desc = 'Open Lazy View' })

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==') -- move line up(n)
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==') -- move line down(n)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv") -- move line down(v)

--Fzf-Lua-Specific Bindings
vim.keymap.set('n', '<leader>sg', function()
  require('fzf-lua').live_grep_glob { resume = true }
end, { desc = '[S]earch with [G]rep Glob' })
vim.keymap.set('n', '<leader><leader>', function()
  require('fzf-lua').files { resume = true }
end, { desc = '[S]earch for [F]iles' })
vim.keymap.set('n', '<leader>sf', function()
  require('fzf-lua').files { resume = true }
end, { desc = '[S]earch for [F]iles' })
vim.keymap.set('n', '<leader>sm', function()
  require('fzf-lua').marks()
end, { desc = '[S]earch for [M]arks' })
vim.keymap.set('n', '<leader>sk', function()
  require('fzf-lua').keymaps()
end, { desc = '[S]earch [K]eymaps' })

-- Map to <leader>uC
vim.keymap.set('n', '<leader>uC', function()
  require('fzf-lua').colorschemes()
end, { desc = 'Colorscheme Picker' })

vim.keymap.set('n', '<leader>bd', function()
  require('bufdelete').bufdelete(0, true)
end, { desc = 'Delete Buffer' })
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
