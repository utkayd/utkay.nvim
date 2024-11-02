return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  opts = {
    position = 'right',
    icons = true,
    mode = 'document_diagnostics',
    fold_open = '', -- icon for open folds
    fold_closed = '', -- icon for closed folds
    group = true, -- group results by file
    padding = true, -- add padding to the list
    action_keys = {
      close = 'q', -- close the list
      refresh = 'r', -- manually refresh
      jump = { '<cr>', '<tab>' }, -- jump to the diagnostic
      open_split = { '<c-x>' }, -- open buffer in split
      open_vsplit = { '<c-v>' }, -- open buffer in vertical split
      open_tab = { '<c-t>' }, -- open buffer in new tab
      jump_close = { 'o' }, -- jump to location and close the list
      toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
      toggle_preview = 'P', -- toggle auto_preview
      hover = 'K', -- opens a small popup with the full multiline message
      preview = 'p', -- preview the diagnostic location
      close_folds = { 'zM', 'zm' }, -- close all folds
      open_folds = { 'zR', 'zr' }, -- open all folds
      toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
      previous = 'k', -- preview item
      next = 'j', -- next item
    },
    signs = {
      error = '',
      warning = '',
      hint = '',
      information = '',
    },
    use_diagnostic_signs = false,
  },
  keys = {
    { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Diagnostics (Trouble)' },
    { '<leader>xX', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Buffer Diagnostics (Trouble)' },
    { '<leader>cs', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
    { '<leader>cS', '<cmd>TroubleToggle lsp_references<cr>', desc = 'LSP references/definitions (Trouble)' },
    { '<leader>xL', '<cmd>TroubleToggle loclist<cr>', desc = 'Location List (Trouble)' },
    { '<leader>xQ', '<cmd>TroubleToggle quickfix<cr>', desc = 'Quickfix List (Trouble)' },
    {
      '[q',
      function()
        if require('trouble').is_open() then
          require('trouble').previous { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Previous Trouble/Quickfix Item',
    },
    {
      ']q',
      function()
        if require('trouble').is_open() then
          require('trouble').next { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Next Trouble/Quickfix Item',
    },
  },
}
