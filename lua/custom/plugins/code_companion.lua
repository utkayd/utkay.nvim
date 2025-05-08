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
        my_openai = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {
              url = 'https://ollama.utkayd.com', -- optional: default value is ollama url http://127.0.0.1:11434
              chat_url = '/v1/chat/completions', -- optional: default value, override if different
              models_endpoint = '/v1/models', -- optional: attaches to the end of the URL to form the endpoint to retrieve models
              credentials = 'OLLAMA_CREDENTIALS',
            },
            headers = {
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Basic ${credentials}',
            },
            schema = {
              model = {
                default = 'qwen3:14b', -- define llm model to be used
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = 'my_openai',
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
          adapter = 'my_openai',
        },
      },
    }
    vim.keymap.set({ 'n', 'v' }, '<leader>aa', ':CodeCompanionChat Toggle<CR>')
    vim.keymap.set({ 'n', 'v' }, '<leader>ae', ':CodeCompanion<CR>')
  end,
}
