# Optimized Neovim Configuration

This Neovim configuration is built with performance and usability in mind. It provides a modern IDE-like experience with intelligent code completion, LSP support, and a clean user interface.

## Features

- 🚀 Fast startup time with optimized lazy-loading
- 🔍 Powerful fuzzy search with Telescope
- 🖥️ Built-in terminal support
- 🌈 Beautiful UI with Catppuccin theme
- 📊 Smart status line
- 📝 LSP integration for intelligent code editing
- 🔄 Git integration with LazyGit and Gitsigns
- 📁 Neo-tree file explorer
- 🔧 Built-in import sorting for cleaner code

## Installation

1. Make sure you have Neovim 0.9.0+ installed
2. Clone this repository to your Neovim configuration directory:

```bash
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
```

3. Start Neovim and let it install the plugins automatically:

```bash
nvim
```

## Key Mappings

### General

| Key           | Mode | Description                  |
|---------------|------|------------------------------|
| `<C-s>`       | n,i,v | Save file                   |
| `<leader>q`   | n    | Quit Neovim                  |
| `<ESC>`       | n    | Clear search highlighting    |
| `<C-j>/<C-d>` | n    | Scroll down (centered)       |
| `<C-k>/<C-u>` | n    | Scroll up (centered)         |
| `<C-v>`       | n    | Vertical split               |
| `<C-Right>`   | n    | Next buffer                  |
| `<C-Left>`    | n    | Previous buffer              |
| `<C-x>`       | n    | Delete buffer                |

### Telescope

| Key              | Description        |
|------------------|--------------------|
| `<leader><leader>` | Find files         |
| `<C-g>`          | Git status         |
| `<leader>fw`     | Find words (grep)  |
| `<C-b>`          | Find buffers       |
| `<leader>ft`     | Find in buffer     |

### Code Navigation

| Key          | Description                 |
|--------------|-----------------------------|
| `<leader>lr` | LSP rename                  |
| `<leader>la` | Code action                 |
| `<leader>ld` | Line diagnostics            |
| `K`          | Hover documentation         |
| `gd`         | Go to definition            |
| `gr`         | Find references             |
| `[d`         | Previous diagnostic         |
| `]d`         | Next diagnostic             |
| `<C-a>`      | Sort imports                |

### Git

| Key           | Description              |
|---------------|--------------------------|
| `<leader>gg`  | Open LazyGit             |
| `<leader>do`  | Open Diffview            |
| `<leader>df`  | File history in Diffview |
| `<leader>dc`  | Close Diffview           |

### File Explorer

| Key          | Description            |
|--------------|------------------------|
| `<leader>e`  | Toggle file explorer   |

## Structure

```
nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── configs/             # Core configuration
│   │   ├── autocmds.lua     # Autocommands
│   │   ├── diagnostics.lua  # Diagnostic settings
│   │   ├── import-format.lua# Import formatting
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── lazy.lua         # Plugin manager setup
│   │   ├── lsp.lua          # LSP configuration
│   │   ├── options.lua      # Neovim options
│   │   └── utils.lua        # Utility functions
│   └── plugins/             # Plugin configurations
└── README.md                # This file
```

## Customization

To modify the configuration:

1. Edit files in `lua/configs/` to change core settings
2. Edit files in `lua/plugins/` to modify plugin behavior
3. Add new plugins by creating files in `lua/plugins/`

## Performance

This configuration is designed to be lightweight and fast. If you experience slowdowns:

1. Check startup time with `nvim --startuptime startup.log`
2. Review lazy-loaded plugins in `lua/plugins/`
3. Adjust LSP configurations in `lua/configs/lsp.lua`

## Credits

This configuration integrates several excellent plugins from the Neovim community. See the individual plugin repositories for their respective licenses and credits.