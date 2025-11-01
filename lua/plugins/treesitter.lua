return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',
    enabled = true,
    config = function()
      -- Set up nvim-treesitter textobjects if nvim-treesitter is loaded
      local treesitter_loaded, treesitter = pcall(require, 'nvim-treesitter.configs')
      if treesitter_loaded then
        treesitter.setup {
          textobjects = {
            select = {
              enable = true,
              -- You can define your keymaps for textobject selection here
              keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = { [']m'] = '@function.outer', [']M'] = '@class.outer' },
              goto_next_end = { [']M'] = '@function.outer', [']C'] = '@class.outer' },
              goto_previous_start = { ['[m'] = '@function.outer', ['[M'] = '@class.outer' },
              goto_previous_end = { ['[M'] = '@function.outer', ['[C'] = '@class.outer' },
            },
          },
        }
      end

      -- Override Treesitter textobjects in diff mode
      local move = require 'nvim-treesitter.textobjects.move'
      local configs = require 'nvim-treesitter.configs'
      for name, fn in pairs(move) do
        if name:find 'goto' == 1 then
          move[name] = function(query, ...)
            if vim.wo.diff then
              local config = configs.get_module('textobjects.move')[name]
              for key, query_str in pairs(config or {}) do
                if query == query_str and key:find '[%]%[][cC]' then
                  vim.cmd('normal! ' .. key)
                  return
                end
              end
            end
            return fn(query, ...)
          end
        end
      end
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
