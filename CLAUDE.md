# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration based on kickstart.nvim, a modular Neovim setup designed to be read and understood line-by-line. The configuration is split between base kickstart functionality and custom plugin additions.

## Architecture

### Configuration Structure

The configuration follows a modular architecture with clear separation of concerns:

```
init.lua                           # Entry point, loads all modules
├── lua/options.lua                # Vim options (line numbers, clipboard, splits, etc.)
├── lua/keymaps.lua                # Global keybindings and autocommands
├── lua/lazy-bootstrap.lua         # Lazy.nvim plugin manager installation
└── lua/lazy-plugins.lua           # Plugin loading configuration
    ├── lua/kickstart/plugins/     # Base kickstart plugins (LSP, treesitter, etc.)
    └── lua/custom/plugins/        # Personal customizations and additional plugins
```

### Plugin Loading System

The configuration uses lazy.nvim as the plugin manager. Plugins are loaded from two locations:
- `lua/kickstart/plugins/` - Core kickstart plugins (LSP, completion, treesitter, formatting, linting)
- `lua/custom/plugins/` - Additional personal plugins (UI enhancements, specialized tools)

Each plugin file returns a table/list that lazy.nvim processes. Plugins can specify lazy-loading triggers like `ft`, `event`, `cmd`, or `keys`.

### LSP Configuration

LSP setup is centralized in `lua/kickstart/plugins/lsp.lua` and uses the **Neovim 0.11+ native LSP API**:

**Core Architecture:**
- Uses `vim.lsp.config(name, config)` to register server configurations
- Uses `vim.lsp.enable(servers)` to start all configured servers
- Mason manages LSP server installation (`williamboman/mason.nvim`)
- Supports multiple language servers (lua_ls, gopls, rust_analyzer, pyright, vtsls, clangd, tailwindcss, etc.)

**Configuration Flow:**
1. Define servers in the `servers` table with their specific settings
2. `vim.lsp.config()` registers each server's configuration
3. `vim.lsp.enable()` starts all servers at once
4. `LspAttach` autocmd handles runtime customizations (keybindings, capabilities modifications)

**Key Features:**
- Per-server configuration via `servers` table with support for capabilities, filetypes, and settings
- Uses `lsp_lines.nvim` for inline diagnostics (virtual_lines enabled, virtual_text disabled)
- LSP keybindings: `<leader>cr` for rename, `<leader>ca` for code actions
- Server capabilities are modified at runtime in the `LspAttach` autocmd (not during config registration)
- Semantic tokens are disabled for Lua files to improve performance

**Special LSP configurations:**
- **Roslyn (C#)**: Configured separately via `lua/custom/plugins/roslyn.lua` with filetype trigger and additional settings in `after/lsp/roslyn.lua`
  - **Known Issue**: Roslyn LSP doesn't properly implement the `$/progress` LSP method (see [dotnet/roslyn#79939](https://github.com/dotnet/roslyn/issues/79939))
  - **Workaround**: LSP progress is disabled in noice.nvim to prevent crashes (see `lua/custom/plugins/noice.lua:9-11`)
- **SchemaStore**: JSON/YAML schemas integration via `b0o/SchemaStore.nvim`
- **Tailwindcss**: Uses helper `extend()` function to merge custom filetypes/settings with lspconfig defaults

**Important Notes:**
- This configuration uses the new Nvim 0.11 API (`vim.lsp.config` and `vim.lsp.enable`)
- The old `lspconfig[name].setup()` pattern is deprecated and will be removed in nvim-lspconfig v3.0.0
- nvim-lspconfig is still included as a dependency to provide default server configurations

### Completion System

Uses `blink.cmp` (`saghen/blink.cmp`) configured in `lua/custom/plugins/blink.lua`:
- Enter-based keymap preset
- Sources: LSP, path, snippets, buffer
- Custom navigation: `<C-j>` next, `<C-k>` previous
- Ghost text enabled
- Cmdline completion available with auto_show disabled

### Formatting and Linting

**Formatting** (conform.nvim):
- Format on save enabled (500ms timeout) with LSP fallback
- Disabled for C/C++ files
- Manual format: `<leader>F`
- Formatters: stylua (Lua), prettier/prettierd (JS/JSON), clang-format (proto)

**Linting** (nvim-lint):
- Configured in `lua/kickstart/plugins/lint.lua`

### Key Custom Modifications

Notable deviations from standard kickstart:

1. **Delete/Change behavior**: `d`, `D`, `c`, `C` operations use black hole register (`"_`) to avoid polluting clipboard
2. **Window navigation**: Alt+hjkl for moving lines, Ctrl+Shift+hjkl for resizing windows
3. **BufferLine integration**: Alt+h/l to move buffers left/right
4. **Macro optimization**: Custom `@` mapping with `noautocmd` for faster macro execution
5. **Save shortcuts**: Ctrl+S in all modes, `<leader>qq` to quit all
6. **Colorscheme**: Uses catppuccin-macchiato (set in init.lua:107)
7. **Statusline**: Custom lualine configuration with Noice integration  support

### Special Integrations

- **Noice**: UI enhancements integrated into lualine (command and mode display)
  - LSP progress disabled globally to prevent Roslyn crashes (Roslyn LSP bug)
  - Includes presets for better command palette, bottom search, and long messages
  - Markdown rendering overrides enabled for better LSP documentation
- **LSP Lines**: Inline diagnostic display replacing virtual text

## Adding New LSP Servers

To add a new language server with the Nvim 0.11 configuration:

1. **Add to the servers table** in `lua/kickstart/plugins/lsp.lua`:
   ```lua
   servers = {
     -- ... existing servers
     your_server = {
       -- Optional: server-specific settings
       settings = {
         yourServer = {
           option = value,
         },
       },
       -- Optional: custom filetypes
       filetypes = { 'yourft' },
       -- Optional: init_options, cmd, etc.
     },
   }
   ```

2. **For Mason-installed servers**: They will be automatically installed via `mason-tool-installer`

3. **For manually installed servers**: Add `manual_install = true`:
   ```lua
   your_server = {
     manual_install = true,
     settings = { ... },
   }
   ```

4. **To modify server capabilities** (like disabling formatting): Add `server_capabilities`:
   ```lua
   your_server = {
     server_capabilities = {
       documentFormattingProvider = false,
     },
   }
   ```
   These are applied at runtime in the `LspAttach` autocmd, not during registration.

5. **For special cases** that need separate plugin configuration (like Roslyn):
   - Create a plugin file in `lua/custom/plugins/`
   - Add after-load config in `after/lsp/` if needed

## Development Commands

### Plugin Management

```bash
# Open Lazy plugin manager UI
:Lazy

# Update all plugins
:Lazy update

# Sync plugins (install/update/clean)
:Lazy sync
```

Or use the keymap: `<leader>l` opens Lazy UI

### LSP and Mason

```bash
# Open Mason UI to manage LSP servers/tools
:Mason

# Install a specific tool
:MasonInstall <tool-name>

# Check LSP server status
:LspInfo

# Check installation health
:checkhealth
```

### Formatting and Diagnostics

```bash
# Format current buffer
<leader>F  # or :ConformInfo to view formatter status

# Toggle diagnostic quickfix list
<leader>q

# Clear search highlights
<Esc>
```

### Testing Configuration Changes

After modifying Lua files:
1. Restart Neovim or use `:source %` on the modified file
2. For plugin changes: `:Lazy reload <plugin-name>` or restart
3. Run `:checkhealth` to diagnose issues
4. For LSP changes: `:LspRestart` to restart language servers

## Troubleshooting

### Roslyn LSP Errors with noice.nvim

**Problem**: Lua errors in `noice.nvim/lua/noice/lsp/progress.lua` when opening C# files:
```
attempt to concatenate field 'token' (a nil value)
```

**Root Cause**: Roslyn LSP server doesn't properly implement the `$/progress` LSP specification method, sending nil tokens.

**Solution**: LSP progress is completely disabled in noice.nvim (`lua/custom/plugins/noice.lua:9-11`). This prevents the LspProgress autocmd from being created.

**Trade-off**: You won't see LSP loading progress indicators for any language server (not just Roslyn), but this is necessary to prevent crashes with Roslyn.

**If you still see errors**:
1. Restart Neovim completely (not just `:Lazy reload`)
2. Ensure noice.nvim is up to date: `:Lazy update noice.nvim`
3. Verify the setting: Run `:lua print(vim.inspect(require('noice.config').options.lsp.progress))` - should show `enabled = false`

### LSP Server Not Starting

1. Check Mason installation: `:Mason` and verify the server is installed
2. Check LSP info: `:LspInfo` to see active clients
3. Run health check: `:checkhealth mason` and `:checkhealth lspconfig`
4. Check server is enabled: Look in `lua/kickstart/plugins/lsp.lua` servers table
5. For Roslyn: Ensure .NET SDK is installed and accessible

## File Conventions

- All Lua files use 2-space indentation (see modeline: `ts=2 sts=2 sw=2 et`)
- Plugin files in `lua/custom/plugins/` should return a table with plugin specification
- After-load configurations go in `after/lsp/` directory (e.g., roslyn.lua)
- Use `vim.schedule()` for settings that can increase startup time (e.g., clipboard sync)

## Important Notes

- Leader key is Space (`<space>`)
- Nerd Font is required (vim.g.have_nerd_font = true)
- Mason registry includes custom registry: `github:Crashdummyy/mason-registry`
- The configuration disables arrow keys in normal mode with educational messages
- Tab width is set to 4 spaces globally (options.lua:65)
