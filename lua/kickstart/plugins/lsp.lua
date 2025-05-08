return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            { path = '/usr/share/awesome/lib/', words = { 'awesome' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
      'b0o/SchemaStore.nvim',
    },
    config = function()
      local extend = function(name, key, values)
        local mod = require(string.format('lspconfig.configs.%s', name))
        local default = mod.default_config
        local keys = vim.split(key, '.', { plain = true })
        while #keys > 0 do
          local item = table.remove(keys, 1)
          default = default[item]
        end

        if vim.islist(default) then
          for _, value in ipairs(default) do
            table.insert(values, value)
          end
        else
          for item, value in pairs(default) do
            if not vim.tbl_contains(values, item) then
              values[item] = value
            end
          end
        end
        return values
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local lspconfig = require 'lspconfig'

      local servers = {
        buf_ls = {
          filetypes = {
            'proto',
          },
        },
        bashls = true,
        gopls = true,
        lua_ls = {
          server_capabilities = {
            semanticTokensProvider = vim.NIL,
          },
        },
        rust_analyzer = true,
        pyright = true,
        ruff = { manual_install = true },
        vtsls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
        },
        jsonls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = '',
              },
            },
          },
        },

        clangd = {
          -- cmd = { "clangd", unpack(require("custom.clangd").flags) },
          init_options = { clangdFileStatus = true },

          filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        },

        tailwindcss = {
          init_options = {
            userLanguages = {
              elixir = 'phoenix-heex',
              eruby = 'erb',
              heex = 'phoenix-heex',
            },
          },
          filetypes = extend('tailwindcss', 'filetypes', { 'ocaml.mlx' }),
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  [[class: "([^"]*)]],
                  [[className="([^"]*)]],
                },
              },
              includeLanguages = extend('tailwindcss', 'settings.tailwindCSS.includeLanguages', {
                ['ocaml.mlx'] = 'html',
              }),
            },
          },
        },
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == 'table' then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require('mason').setup()
      local ensure_installed = {
        'stylua',
        'lua_ls',
        'delve',
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend('force', {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), 'must have valid client')

          local settings = servers[client.name]
          if type(settings) ~= 'table' then
            settings = {}
          end

          vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end

          if settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                ---@diagnostic disable-next-line: cast-local-type
                v = nil
              end

              client.server_capabilities[k] = v
            end
          end
        end,
      })

      require('lsp_lines').setup()
      vim.diagnostic.config { virtual_text = true, virtual_lines = false }

      -- vim.keymap.set('', '<leader>l', function()
      --   local config = vim.diagnostic.config() or {}
      --   if config.virtual_text then
      --     vim.diagnostic.config { virtual_text = false, virtual_lines = true }
      --   else
      --     vim.diagnostic.config { virtual_text = true, virtual_lines = false }
      --   end
      -- end, { desc = 'Toggle lsp_lines' })
    end,
  },
}
