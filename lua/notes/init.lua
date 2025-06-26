local M = {}
local note_dir = vim.fn.stdpath("data") .. "/nvim-notes"

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
  table.sort(files)
  return files
end

-- Open a note
function M.open()
  local notes = get_notes()
  if #notes == 0 then
    print("No notes found.")
    return
  end

  vim.ui.select(notes, { prompt = "Open Note:" }, function(choice)
    if choice then
      vim.cmd("edit " .. note_dir .. "/" .. choice)
    end
  end)
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

return M
