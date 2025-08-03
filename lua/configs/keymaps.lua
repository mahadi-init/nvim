Key({ 'n', 'i', 'v' }, '<C-s>', '<CMD>w<CR>') -- save file
Key('n', '<leader>q', '<CMD>q<CR>') -- quit neovim
Key('n', '<ESC>', '<CMD>nohlsearch<CR>') -- escape and remove search query
Key('n', '<C-j>', '<C-d>zz') -- scroll down
Key('n', '<C-k>', '<C-u>zz') -- scroll up
Key('n', '<C-d>', '<C-d>zz') -- scroll down
Key('n', '<C-u>', '<C-u>zz') -- scroll up
Key('n', '<C-v>', '<CMD>leftabove vsplit<CR>') -- vertical split

-- quickfix
Key('n', '<M-o>', '<CMD>copen<CR>', { desc = 'Open quickfix' })
Key('n', '<M-x>', '<CMD>cclose<CR>', { desc = 'close quickfix' })
Key('n', '<M-k>', '<CMD>cprev<CR>', { desc = 'previous quickfix' })
Key('n', '<M-j>', '<CMD>cnext<CR>', { desc = 'next quickfix' })
Key('n', '<M-d>', function()
  local qf_list = vim.fn.getqflist()
  local current_line = vim.fn.line '.'
  table.remove(qf_list, current_line)
  vim.fn.setqflist(qf_list, 'r')
end, { desc = 'Remove current quickfix entry' })

-- resize window
Key('n', '=', [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
-- Key('n', '-', [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
--
vim.keymap.set('n', '<M-Up>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<M-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('n', '<M-Down>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('v', '<M-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

-- buffer chnage
Key('n', '<C-Right>', '<CMD>bnext<CR>')
Key('n', '<C-Left>', '<CMD>bprev<CR>')

-- session
Key('n', '<leader>ls', function()
  require('persistence').load()
end)

-- Note taking file keybind
Key('n', '<C-n>', function()
  local note_dir = vim.fn.expand '~/.local/share/nvim'
  local note_file = note_dir .. '/note.md'

  -- Create directory if it doesn't exist
  vim.fn.mkdir(note_dir, 'p')

  -- Check if file exists, if not create it with basic content
  local file = io.open(note_file, 'r')
  if not file then
    -- File doesn't exist, create it with basic markdown header
    local new_file = io.open(note_file, 'w')
    if new_file then
      new_file:write '# Neovim Notes\n\n'
      new_file:write('Created: ' .. os.date '%B %d, %Y at %I:%M %p' .. '\n')
      new_file:write('Updated: ' .. os.date '%B %d, %Y at %I:%M %p' .. '\n\n')
      new_file:write '---\n\n'
      new_file:close()
    end
  else
    file:close()
  end

  -- Open the file
  vim.cmd('edit ' .. note_file)

  -- Set up autocmd to update timestamp only when file is saved after changes
  vim.cmd [[
        augroup NoteTimestamp
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua
            \ if vim.bo.modified then
            \   local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false);
            \   for i, line in ipairs(lines) do
            \     if line:match('^Updated:') then
            \       lines[i] = 'Updated: ' .. os.date('%B %d, %Y at %I:%M %p');
            \       vim.api.nvim_buf_set_lines(0, 0, -1, false, lines);
            \       break;
            \     end;
            \   end;
            \ end
        augroup END
    ]]
end)
