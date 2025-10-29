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
      -- Helper function to extend default lspconfig values
      -- Used for servers like tailwindcss that need to merge with defaults
      local extend = function(name, key, values)
        -- In Nvim 0.11, we can still access lspconfig defaults for merging
        local ok, mod = pcall(require, string.format('lspconfig.configs.%s', name))
        if not ok then
          return values
        end
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

      -- Configure all LSP floating windows with rounded borders
      local border_opts = {
        border = 'rounded',
      }

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, border_opts)
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, border_opts)

      -- Set default border for all floating windows
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      local servers = {
        buf_ls = {
          filetypes = {
            'proto',
          },
        },
        bashls = {},
        gopls = {},
        lua_ls = {
          server_capabilities = {
            semanticTokensProvider = vim.NIL,
          },
        },
        rust_analyzer = {},
        pyright = {},
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

      -- Setup Mason for LSP server installation management
      require('mason').setup {
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry',
        },
      }
      local ensure_installed = {
        'stylua',
        'lua_ls',
        'delve',
        'prettier',
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Configure each LSP server using the new Nvim 0.11 API
      for name, config in pairs(servers) do
        -- Normalize config
        if type(config) == 'boolean' then
          config = {}
        end

        -- Add capabilities to config
        config = vim.tbl_deep_extend('force', {}, {
          capabilities = capabilities,
        }, config)

        -- Extract server_capabilities for LspAttach handling (don't pass to vim.lsp.config)
        -- These are applied in the LspAttach autocmd below
        config.server_capabilities = nil

        -- Register the server configuration using Nvim 0.11+ API
        -- This replaces the deprecated lspconfig[name].setup(config)
        vim.lsp.config(name, config)
      end

      -- Enable all configured servers using Nvim 0.11+ API
      -- This enables the servers globally - they will start based on root_dir detection
      vim.lsp.enable(vim.tbl_keys(servers))

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
      vim.diagnostic.config {
        virtual_text = false,
        virtual_lines = true,
        float = { border = 'rounded' },
      }

      -- Remove background from lsp_lines virtual text
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = vim.api.nvim_get_hl(0, { name = 'DiagnosticError' }).fg, bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn' }).fg, bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = vim.api.nvim_get_hl(0, { name = 'DiagnosticInfo' }).fg, bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = vim.api.nvim_get_hl(0, { name = 'DiagnosticHint' }).fg, bg = 'NONE' })
    end,
  },
}
