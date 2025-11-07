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
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--Save with Control+s
vim.keymap.set('n', '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })
vim.keymap.set('x', '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })
vim.keymap.set('i', '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })
vim.keymap.set('s', '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

--Quit with leader qq
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

--Select All Text
vim.keymap.set('n', 'vig', function()
  vim.cmd 'normal! gg0vG$'
end, { desc = 'Select All Text' })
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<Cr>', { desc = 'Open Lazy View' })

vim.keymap.set('n', '<A-j>', '<cmd>m .+1<CR>==', { silent = true, desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<CR>==', { silent = true, desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', "<cmd>m '>+1<CR>gv=gv", { silent = true, desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', "<cmd>m '<-2<CR>gv=gv", { silent = true, desc = 'Move selection up' })

vim.keymap.set('n', '@', function()
  local count = vim.v.count1
  local char = vim.fn.getcharstr()
  vim.cmd('noautocmd norm! ' .. count .. '@' .. char)
end)

vim.keymap.set('n', '<M-S-l>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<M-S-h>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<M-S-j>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<M-S-k>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })

-- Force bar cursor in terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt_local.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25,a:blinkwait700-blinkoff400-blinkon250'
  end,
})
-- vim: ts=2 sts=2 sw=2 et
