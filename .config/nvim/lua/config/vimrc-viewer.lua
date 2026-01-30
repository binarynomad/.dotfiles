-- Vim Cheatsheet Viewer
-- Fetches and displays the vim cheatsheet from GitHub .vimrc

local M = {}

-- Configuration
local GITHUB_URL = "https://raw.githubusercontent.com/binarynomad/.dotfiles/main/.vimrc"
local CACHE_FILE = vim.fn.stdpath("cache") .. "/vimrc_cheatsheet.txt"

-- Private: Fetch content from GitHub
local function fetch_from_github()
  local content = vim.fn.system("curl -s -f " .. GITHUB_URL)
  if vim.v.shell_error ~= 0 then
    return nil, "Failed to fetch from GitHub. Check your internet connection."
  end
  return content, nil
end

-- Private: Parse the my_vim_cheatsheet section from vimrc content
local function parse_cheatsheet(content)
  if not content or content == "" then
    return nil, "Empty content received"
  end

  local lines = {}
  local in_cheatsheet = false
  local found_start = false

  for line in content:gmatch("[^\r\n]+") do
    -- Look for the start of the cheatsheet
    if line:match("let%s+my_vim_cheatsheet%s*=%s*%[") then
      in_cheatsheet = true
      found_start = true
    elseif in_cheatsheet then
      -- Check for end of array
      if line:match("^%s*\\%]") then
        break
      end

      -- Clean up the line
      local cleaned = line
      -- Remove leading backslash and space
      cleaned = cleaned:gsub("^%s*\\%s*", "")
      -- Remove leading and trailing quotes
      cleaned = cleaned:gsub('^"', ""):gsub('"$', "")
      -- Remove trailing comma
      cleaned = cleaned:gsub(",$", "")
      -- Remove escape backslashes
      cleaned = cleaned:gsub('\\"', '"')

      table.insert(lines, cleaned)
    end
  end

  if not found_start then
    return nil, "Cheatsheet section not found in .vimrc"
  end

  if #lines == 0 then
    return nil, "Cheatsheet section is empty"
  end

  return lines, nil
end

-- Private: Save lines to cache file
local function save_to_cache(lines)
  -- Ensure cache directory exists
  local cache_dir = vim.fn.stdpath("cache")
  vim.fn.mkdir(cache_dir, "p")

  -- Write to cache file
  local success = pcall(vim.fn.writefile, lines, CACHE_FILE)
  return success
end

-- Private: Load lines from cache file
local function load_from_cache()
  if vim.fn.filereadable(CACHE_FILE) == 1 then
    local success, lines = pcall(vim.fn.readfile, CACHE_FILE)
    if success then
      return lines
    end
  end
  return nil
end

-- Private: Create and display floating window
local function create_floating_window(lines, title)
  -- Calculate window dimensions (80% of screen)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "text")

  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Window options
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = title or " Vim Cheatsheet ",
    title_pos = "center",
  }

  -- Open floating window
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Set window options
  vim.api.nvim_win_set_option(win, "number", true)
  vim.api.nvim_win_set_option(win, "relativenumber", true)

  -- Make buffer read-only after content is set
  vim.api.nvim_buf_set_option(buf, "modifiable", false)

  -- Set buffer-local keymaps to close window
  local close_cmd = "<cmd>close<CR>"
  vim.api.nvim_buf_set_keymap(buf, "n", "q", close_cmd, { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", close_cmd, { noremap = true, silent = true })
end

-- Private: Show error message in floating window
local function show_error(message)
  local error_lines = {
    "",
    "ERROR: Unable to display Vim Cheatsheet",
    "",
    message,
    "",
    "Suggestions:",
    "- Check your internet connection",
    "- Press <leader>hr to retry fetching from GitHub",
    "- Verify the repository is accessible",
    "",
    "Press 'q' or <Esc> to close this window",
    "",
  }
  create_floating_window(error_lines, " Error ")
end

-- Public: Show the cheatsheet (from cache or fetch if needed)
function M.show_cheatsheet()
  -- Try to load from cache first
  local lines = load_from_cache()

  if lines then
    -- Cache exists, display it
    create_floating_window(lines, " Vim Cheatsheet ")
    return
  end

  -- No cache, fetch from GitHub
  local content, err = fetch_from_github()

  if err then
    show_error(err)
    return
  end

  -- Parse the cheatsheet section
  lines, err = parse_cheatsheet(content)

  if err then
    show_error(err)
    return
  end

  -- Save to cache
  save_to_cache(lines)

  -- Display
  create_floating_window(lines, " Vim Cheatsheet ")
end

-- Public: Refresh the cheatsheet cache from GitHub
function M.refresh_cheatsheet()
  -- Fetch fresh content from GitHub
  local content, err = fetch_from_github()

  if err then
    vim.notify("Failed to refresh cheatsheet: " .. err, vim.log.levels.ERROR)
    return
  end

  -- Parse the cheatsheet section
  local lines, parse_err = parse_cheatsheet(content)

  if parse_err then
    vim.notify("Failed to parse cheatsheet: " .. parse_err, vim.log.levels.ERROR)
    return
  end

  -- Save to cache
  local success = save_to_cache(lines)

  if success then
    vim.notify("Cheatsheet cache refreshed", vim.log.levels.INFO)
  else
    vim.notify("Failed to save cheatsheet to cache", vim.log.levels.WARN)
  end
end

return M
