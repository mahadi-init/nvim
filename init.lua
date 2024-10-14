-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'config.remove-padding'
require 'config.lazy'
require 'config.options'
require 'config.cmpconfig'
require 'config.lspconfig'
require 'config.autocmds'
require 'config.keymaps'
