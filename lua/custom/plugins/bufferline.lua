return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
    { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
  },
  opts = {
    options = {
      close_command = function(n)
        require('bufdelete').bufdelete(n, true)
      end, -- Use 'bufdelete' instead of LazyVim's custom command
      right_mouse_command = function(n)
        require('bufdelete').bufdelete(n, true)
      end, -- Same here
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      diagnostics_indicator = function(count, level, diagnostics_dict)
        local symbols = { error = ' ', warning = ' ', info = ' ' } -- Replace icons if needed
        local result = {}
        for key, value in pairs(diagnostics_dict) do
          if symbols[key] then
            table.insert(result, symbols[key] .. value)
          end
        end
        return table.concat(result, ' ')
      end,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
      get_element_icon = function(buffer)
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(buffer.filetype)
        return icon or '', hl -- Use default icons if none found
      end,
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
      callback = function()
        vim.schedule(function()
          pcall(vim.cmd, 'BufferLineRefresh') -- Refresh bufferline explicitly
        end)
      end,
    })
  end,
}
