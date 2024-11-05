return {
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = {
      -- add blink.compat to dependencies
      { 'saghen/blink.compat', opts = { impersonate_nvim_cmp = true } },
      { 'rafamadriz/friendly-snippets' },
    },

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      keymap = { preset = 'enter', ['<C-k>'] = { 'select_prev', 'fallback' }, ['<C-j>'] = { 'select_next', 'fallback' } },

      highlight = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',

      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = true } },

      -- experimental signature help support
      trigger = { signature_help = { enabled = true } },
      sources = {
        completion = {
          enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'codeium' },
        },
        providers = {
          lsp = {
            name = 'LSP',
            module = 'blink.cmp.sources.lsp',

            --- *All* of the providers have the following options available
            --- NOTE: All of these options may be functions to get dynamic behavior
            --- See the type definitions for more information
            enabled = true, -- whether or not to enable the provider
            transform_items = nil, -- function to transform the items before they're returned
            should_show_items = true, -- whether or not to show the items
            max_items = nil, -- maximum number of items to return
            min_keyword_length = 0, -- minimum number of characters to trigger the provider
            fallback_for = {}, -- if any of these providers return 0 items, it will fallback to this provider
            score_offset = 0, -- boost/penalize the score of the items
            override = nil, -- override the source's functions
          },
          path = {
            name = 'Path',
            module = 'blink.cmp.sources.path',
            score_offset = 3,
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
              end,
              show_hidden_files_by_default = false,
            },
          },
          snippets = {
            name = 'Snippets',
            module = 'blink.cmp.sources.snippets',
            score_offset = -3,
            opts = {
              friendly_snippets = true,
              search_paths = { vim.fn.stdpath 'config' .. '/snippets' },
              global_snippets = { 'all' },
              extended_filetypes = {},
              ignored_filetypes = {},
            },

            --- Example usage for disabling the snippet provider after pressing trigger characters (i.e. ".")
            -- enabled = function(ctx) return ctx ~= nil and ctx.trigger.kind == vim.lsp.protocol.CompletionTriggerKind.TriggerCharacter end,
          },
          buffer = {
            name = 'Buffer',
            module = 'blink.cmp.sources.buffer',
            fallback_for = { 'lsp' },
          },
          codeium = {
            name = 'codeium',
            module = 'blink.compat.source',

            score_offset = 10,
          },
        },
      },
      windows = {
        autocomplete = {
          min_width = 15,
          max_height = 10,
          border = 'padded',
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
          -- keep the cursor X lines away from the top/bottom of the window
          scrolloff = 2,
          -- note that the gutter will be disabled when border ~= 'none'
          scrollbar = true,
          -- which directions to show the window,
          -- falling back to the next direction when there's not enough space
          direction_priority = { 's', 'n' },
          -- Controls whether the completion window will automatically show when typing
          auto_show = true,
          -- Controls how the completion items are selected
          -- 'preselect' will automatically select the first item in the completion list
          -- 'manual' will not select any item by default
          -- 'auto_insert' will not select any item by default, and insert the completion items automatically when selecting them
          selection = 'preselect',
          -- Controls how the completion items are rendered on the popup window
          -- 'simple' will render the item's kind icon the left alongside the label
          -- 'reversed' will render the label on the left and the kind icon + name on the right
          -- 'minimal' will render the label on the left and the kind name on the right
          -- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
          draw = 'reversed',
          -- Controls the cycling behavior when reaching the beginning or end of the completion list.
          cycle = {
            -- When `true`, calling `select_next` at the *bottom* of the completion list will select the *first* completion item.
            from_bottom = true,
            -- When `true`, calling `select_prev` at the *top* of the completion list will select the *last* completion item.
            from_top = true,
          },
        },
        documentation = {
          min_width = 10,
          max_width = 60,
          max_height = 20,
          border = 'padded',
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
          -- note that the gutter will be disabled when border ~= 'none'
          scrollbar = true,
          -- which directions to show the documentation window,
          -- for each of the possible autocomplete window directions,
          -- falling back to the next direction when there's not enough space
          direction_priority = {
            autocomplete_north = { 'e', 'w', 'n', 's' },
            autocomplete_south = { 'e', 'w', 's', 'n' },
          },
          -- Controls whether the documentation window will automatically show when selecting a completion item
          auto_show = true,
          auto_show_delay_ms = 500,
          update_delay_ms = 50,
        },
        signature_help = {
          min_width = 1,
          max_width = 100,
          max_height = 10,
          border = 'padded',
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
          -- note that the gutter will be disabled when border ~= 'none'
          scrollbar = false,

          -- which directions to show the window,
          -- falling back to the next direction when there's not enough space
          direction_priority = { 'n', 's' },
        },
        ghost_text = {
          enabled = true,
        },
      },
    },
  },

  -- LSP servers and clients communicate what features they support through "capabilities".
  --  By default, Neovim support a subset of the LSP specification.
  --  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
  --  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
  --
  -- This can vary by config, but in-general for nvim-lspconfig:

  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function(_, opts)
      local lspconfig = require 'lspconfig'
      for server, config in pairs(opts.servers or {}) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
}
