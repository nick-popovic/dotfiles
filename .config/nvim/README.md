# Neovim Configuration

This is my personal Neovim configuration, managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

## Explicitly Imported Plugins

Below is the list of plugins that are explicitly imported as top-level plugins in the configuration files (dependencies implicitly loaded by lazy.nvim are omitted):

### Core & Plugin Management
- **[lazy.nvim](https://github.com/folke/lazy.nvim):** A modern, fast, and feature-rich plugin manager for Neovim.

### Appearance & Themes
- **Themes:**
  - **[catppuccin](https://github.com/catppuccin/nvim):** A soothing pastel theme.
  - **[everforest-nvim](https://github.com/neanias/everforest-nvim):** A green-based color scheme designed to be warm and soft.
  - **[gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim):** A Lua port of the famous retro groove colorscheme.
  - **[rose-pine](https://github.com/rose-pine/neovim):** A theme with "Soho vibes" featuring warm and muted colors.
  - **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim):** A clean, dark theme with bright, vibrant colors.
- **[themery.nvim](https://github.com/zaldih/themery.nvim):** A utility plugin to quickly toggle and manage multiple themes.
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim):** A highly customizable, fast statusline plugin written in pure Lua.

### UI Enhancements
- **[noice.nvim](https://github.com/folke/noice.nvim):** Completely replaces the UI for messages, cmdline, and popup menu with a highly experimental and modern interface.
- **[which-key.nvim](https://github.com/folke/which-key.nvim):** Displays a popup with possible key bindings of the command you started typing, making it easy to remember shortcuts.

### Navigation & Searching
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim):** A highly extendable fuzzy finder over lists (files, grep, buffers, etc.).
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim):** A file system explorer and tree viewer with advanced capabilities.

### Language Servers, Formatting & Syntax
- **[mason.nvim](https://github.com/williamboman/mason.nvim):** A portable package manager to easily install and manage LSP servers, DAP servers, linters, and formatters.
- **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim):** Bridges the gap between `mason.nvim` and `nvim-lspconfig`, making it easier to setup LSPs installed via Mason.
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig):** A collection of quickstart configurations for Neovim's built-in LSP client.
- **[conform.nvim](https://github.com/stevearc/conform.nvim):** A lightweight yet powerful formatter plugin to run external formatters automatically or on demand.
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter):** Provides advanced syntax highlighting, code navigation, and structural parsing.

### Debugging (DAP)
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap):** The core Debug Adapter Protocol client implementation for debugging code directly in Neovim.

### Git Integration
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim):** Super fast git decorations (added/removed/modified signs) in the gutter, line blame, and inline diffs.
