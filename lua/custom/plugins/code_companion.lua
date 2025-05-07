return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/mcphub.nvim',
  },
  config = function()
    require('codecompanion').setup {
      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {},
          })
        end,
      },
      strategies = {
        chat = {
          adapter = 'openai',
          agents = {
            tools = {
              ['mcp'] = {
                callback = require 'mcphub.extensions.codecompanion',
                description = 'Call tools and resources from the MCP Servers',
                opts = {
                  user_approval = true,
                },
              },
            },
          },
        },
        inline = {
          adapter = 'openai',
        },
      },
    }
  end,
}
