local M = {}
local fzf = require("fzf-lua")
local note_dir = vim.fn.stdpath("data") .. "/nvim-notes"
local repo_url = "https://github.com/mahadi-init/neovim-notes"

local function ensure_note_dir()
  if vim.fn.isdirectory(note_dir) == 0 then
    vim.fn.mkdir(note_dir, "p")
  end
end

-- Extract YAML front matter (tags)
local function parse_tags(path)
  local tags = {}
  local lines = vim.fn.readfile(path)
  if lines[1] ~= "---" then return tags end

  for i = 2, #lines do
    if lines[i] == "---" then break end
    local key, value = string.match(lines[i], "(%w+):%s*(.+)")
    if key == "tags" then
      for tag in string.gmatch(value, "[^,%s]+") do
        table.insert(tags, tag)
      end
    end
  end

  return tags
end

-- List all notes
local function get_notes()
  ensure_note_dir()
  local files = vim.fn.readdir(note_dir)
  local filtered = {}

  for _, file in ipairs(files) do
    if file ~= ".git" and file:match("%.md$") then
      table.insert(filtered, file)
    end
  end

  table.sort(filtered)
  return filtered
end

-- Open a note
function M.open()
  ensure_note_dir()

  -- Filter notes: ignore hidden files/folders like `.git`, and allow only `.md` files
  local all_files = vim.fn.readdir(note_dir)
  local files = vim.tbl_filter(function(file)
    return not file:match("^%.") and file:match("%.md$")
  end, all_files)

  if #files == 0 then
    print("No notes found.")
    return
  end

  fzf.fzf_exec(files, {
    prompt = "Notes> ",
    previewer = false,
    actions = {
      ["default"] = function(selected)
        vim.cmd("edit " .. note_dir .. "/" .. selected[1])
      end,
      ["d"] = function(selected)
        local file = selected[1]
        local confirm = vim.fn.input("Delete '" .. file .. "'? (y/n): ")
        if confirm:lower() == "y" then
          local ok = os.remove(note_dir .. "/" .. file)
          if ok then
            print("Deleted note:", file)
          else
            print("Failed to delete.")
          end
        else
          print("Aborted.")
        end
      end,
    },
  })
end

-- Create a new note with optional tag input
function M.new()
  ensure_note_dir()
  local name = vim.fn.input("Note name: ")
  if name == "" then
    name = os.date("%Y-%m-%d_%H-%M-%S")
  end
  local tags = vim.fn.input("Tags (comma-separated): ")
  local path = string.format("%s/%s.md", note_dir, name)

  if vim.fn.filereadable(path) == 0 then
    local file = io.open(path, "w")
    if file ~= nil then
      file:write("---\n")
      file:write("tags: " .. tags .. "\n")
      file:write("---\n\n")
      file:close()
    end
  end

  vim.cmd("edit " .. path)
end

-- Get all tags from all notes
local function collect_all_tags()
  local tag_map = {}
  for _, file in ipairs(get_notes()) do
    local tags = parse_tags(note_dir .. "/" .. file)
    for _, tag in ipairs(tags) do
      tag_map[tag] = true
    end
  end
  local tag_list = vim.tbl_keys(tag_map)
  table.sort(tag_list)
  return tag_list
end

-- Use ui.select to choose a tag and show related notes
function M.tag_search()
  local all_tags = collect_all_tags()

  if #all_tags == 0 then
    print("No tags found.")
    return
  end

  vim.ui.select(all_tags, { prompt = "Select Tag:" }, function(tag_choice)
    if not tag_choice then return end

    local matches = {}
    for _, file in ipairs(get_notes()) do
      local tags = parse_tags(note_dir .. "/" .. file)
      for _, t in ipairs(tags) do
        if t == tag_choice then
          table.insert(matches, file)
          break
        end
      end
    end

    if #matches == 0 then
      print("No notes with tag:", tag_choice)
      return
    end

    vim.ui.select(matches, { prompt = "Notes tagged '" .. tag_choice .. "':" }, function(choice)
      if choice then
        vim.cmd("edit " .. note_dir .. "/" .. choice)
      end
    end)
  end)
end

function M.sync()
  local path = vim.fn.expand(note_dir)

  if vim.fn.isdirectory(path) == 0 then
    -- Clone silently without breaking UI
    print("Cloning notes from GitHub...")
    local output = vim.fn.system({ "git", "clone", repo_url, path })

    if vim.v.shell_error == 0 then
      print("✅ Notes cloned successfully.")
    else
      print("❌ Failed to clone repo:")
      print(output)
    end
    return
  end

  -- Folder exists: check for changes
  local status = vim.fn.system({ "git", "-C", path, "status", "--porcelain" })

  if status ~= "" then
    print("🔄 Syncing notes to GitHub...")
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")

    -- Run Git commands silently
    vim.fn.system({ "git", "-C", path, "add", "." })
    vim.fn.system({ "git", "-C", path, "commit", "-m", "sync: " .. timestamp })
    local push_output = vim.fn.system({ "git", "-C", path, "push" })

    if vim.v.shell_error == 0 then
      print("✅ Notes synced successfully.")
    else
      print("❌ Push failed:")
      print(push_output)
    end
  else
    print("🟢 No changes to sync.")
  end
end

function M.setup()
  vim.api.nvim_create_user_command("NoteNew", M.new, {})
  vim.api.nvim_create_user_command("NoteOpen", M.open, {})
  vim.api.nvim_create_user_command("NoteByTag", M.tag_search, {})
  vim.api.nvim_create_user_command("NoteSync", M.sync, {})
end

return M
