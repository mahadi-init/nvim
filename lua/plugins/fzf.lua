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

    Key('n', '<leader><leader>', fzf.files, { desc = 'find files' })
    Key('n', '<C-g>', fzf.git_status, { desc = 'git status' })
    Key('n', '<leader>fw', fzf.live_grep, { desc = 'find words' })
    Key('n', '<C-b>', fzf.buffers, { desc = 'Find buffer' })
    Key('n', '<leader>ft', fzf.grep_curbuf, { desc = 'find text current buffer' })
  end
}
