-- Scooter - Interactive search and replace TUI
-- https://github.com/thomasschafer/scooter

local scooter_term = nil

-- Function to open a file at a specific line from scooter
_G.EditLineFromScooter = function(file_path, line)
  if scooter_term and scooter_term:buf_valid() then
    scooter_term:hide()
  end

  local current_path = vim.fn.expand '%:p'
  local target_path = vim.fn.fnamemodify(file_path, ':p')

  if current_path ~= target_path then
    vim.cmd.edit(vim.fn.fnameescape(file_path))
  end

  vim.api.nvim_win_set_cursor(0, { line, 0 })
end

local function is_terminal_running(term)
  if not term or not term:buf_valid() then
    return false
  end
  local channel = vim.fn.getbufvar(term.buf, 'terminal_job_id')
  return channel and vim.fn.jobwait({ channel }, 0)[1] == -1
end

local function open_scooter()
  if is_terminal_running(scooter_term) then
    scooter_term:toggle()
  else
    scooter_term = require('snacks').terminal.open('scooter', {
      win = {
        position = 'float',
        border = 'rounded',
        title = ' Scooter ',
        title_pos = 'center',
      },
    })
  end
end

local function open_scooter_with_text(search_text)
  if scooter_term and scooter_term:buf_valid() then
    scooter_term:close()
  end

  local escaped_text = vim.fn.shellescape(search_text:gsub('\r?\n', ' '))
  scooter_term = require('snacks').terminal.open('scooter --fixed-strings --search-text ' .. escaped_text, {
    win = {
      position = 'float',
      border = 'rounded',
      title = ' Scooter ',
      title_pos = 'center',
    },
  })
end

return {
  -- Scooter requires snacks.nvim for terminal integration
  'folke/snacks.nvim',
  keys = {
    {
      '<leader>sr',
      open_scooter,
      desc = 'Scooter (Search & Replace)',
    },
    {
      '<leader>sr',
      function()
        local selection = vim.fn.getreg '"'
        vim.cmd 'normal! "ay'
        open_scooter_with_text(vim.fn.getreg 'a')
        vim.fn.setreg('"', selection)
      end,
      mode = 'v',
      desc = 'Search selected text in Scooter',
    },
  },
}
