require 'configs.options'
require 'configs.autocmds'
require 'configs.lazy'
require 'configs.keymaps'
require 'configs.lsp'
require("notes")

local note = require("notes")

vim.api.nvim_create_user_command("NoteNew", note.new, {})
vim.api.nvim_create_user_command("NoteOpen", note.open, {})
vim.api.nvim_create_user_command("NoteByTag", note.tag_search, {})
