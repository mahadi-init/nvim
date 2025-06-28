return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  opts = {},
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      actions = {
        ['tab'] = require('fzf-lua.actions').toggle_select,
        ['default'] = require('fzf-lua.actions').qf_add,
      },
      file_ignore_patterns = {
        '^.git/',
        '^node_modules/',
        '^%.next/',
        '%.o$',
        '%.a$',
        '%.out$',
        '%.class$',
        '%.pdf$',
        '%.zip$',
        "^dist",
        "bun.lock",
        "venv"
      },
    })

    vim.keymap.set('n', '<leader><leader>', fzf.files, { desc = 'find files' })
    vim.keymap.set('n', '<C-g>', fzf.git_status, { desc = 'git status' })
    vim.keymap.set('n', '<leader>fw', fzf.live_grep, { desc = 'find words' })
    vim.keymap.set('n', '<C-b>', fzf.buffers, { desc = 'Find buffer' })
    vim.keymap.set('n', '<leader>ft', fzf.grep_curbuf, { desc = 'find text current buffer' })
  end
}
