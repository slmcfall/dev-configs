-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

--------------------------------------
-- snippets --------------------------
--------------------------------------
-- va{ >>> visual mode select { inclusive
-- vi{ >>> visual mode select { inner
-- yi{ >>> go to start of specified character, inner
-- vaW, inclues whitespace >>> visual mode, select word + whitespace
-- g; move to last edit location
-- g, move to next edit location
-- up 1/2 page: ctrl+u
-- down 1/2 page: ctrl+d

--------
--- disable
--------
keymap.set({ 'n', 'x' }, 's', '<Nop>')
keymap.set('n', '<C-t>', '<Nop>')

--------------------------------------
-- general ---------------------------
--------------------------------------

-- put most recent yank
-- keymap.set("n", "<leader>p", '"0p', { desc = "Put most recent yank" })

-- save file
keymap.set("n", "<leader>ww", "<cmd>w<CR>", { desc = "Save file" })

-- use kj to exit insert mode
keymap.set("i", "kj", "<ESC><cmd>w<CR>", { desc = "Exit insert mode with kj" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

keymap.set("n", "<leader>bs", ":%s/", { desc = "Search/Replace buffer" })
keymap.set("n", ";", ":<C-f>", { desc = "CMD mode editor" })

------------
-- SPLITS --
------------
-- open select file in tree in new VERTICAL split: ctrl+v
-- open select file in tree in new HORIZONAL split: ctrl+x
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>sb", "<cmd>sbp<CR>", { desc = "Open previous buffer in a split" })
keymap.set("n", "<leader>so", "<cmd>only<CR>", { desc = "Close every other split except the current one" })

----------
-- TABS --
----------
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })


------------
-- macros --
------------
keymap.set("n", "<leader>ae", "<C-V>lllllljjxA<BS><ESC>jA<BS><ESC><cmd>w<CR>", { desc = "Format aws env var creds" })



----------
-- dbt --
----------
local function open_compiled_buffer()
  -- Get the current buffer's full path
  local current_path = vim.api.nvim_buf_get_name(0)
  print("Current path: " .. current_path)

  -- Transform the path
  local compiled_path = current_path:gsub(
    "^(.*/mindoula_dbt_athena)/models/(.*)$",
    "%1/target/compiled/mindoula_dbt_athena/models/%2"
  )
  print("Compiled path after gsub: " .. compiled_path)

  -- Check if the compiled file exists
  if vim.fn.filereadable(compiled_path) == 1 then
    -- Open the compiled file in a new buffer
    vim.cmd('vsplit ' .. vim.fn.fnameescape(compiled_path))
    print("Opened compiled file: " .. compiled_path)
  else
    print("Compiled file not found: " .. compiled_path)
  end
end

local function open_run_buffer()
  -- Get the current buffer's full path
  local current_path = vim.api.nvim_buf_get_name(0)
  print("Current path: " .. current_path)

  -- Transform the path
  local compiled_path = current_path:gsub(
    "^(.*/mindoula_dbt_athena)/models/(.*)$",
    "%1/target/run/mindoula_dbt_athena/models/%2"
  )
  print("Compiled path after gsub: " .. compiled_path)

  -- Check if the compiled file exists
  if vim.fn.filereadable(compiled_path) == 1 then
    -- Open the compiled file in a new buffer
    vim.cmd('vsplit ' .. vim.fn.fnameescape(compiled_path))
    print("Opened run file: " .. compiled_path)
  else
    print("Compiled run not found: " .. compiled_path)
  end
end

function _G.run_dbt_for_current_buffer(dbt_run_command, upstream, downstream)
  dbt_run_command = dbt_run_command or "dbt run -m"
  upstream = upstream or false
  downstream = downstream or false

  local model_name = vim.fn.expand('%:t:r')
  local buffer_dir = vim.fn.getcwd()

  if upstream then
    model_name = "+" .. model_name
  end
  if downstream then
    model_name = model_name .. "+"
  end

  local dbt_command = string.format('cd %s && poetry run %s %s --profiles-dir %s', buffer_dir, dbt_run_command,
    model_name, buffer_dir)
  local escaped_command = dbt_command:gsub("'", "'\\''")
  local tmux_command = string.format(
    "tmux split-window -v 'source ~/.zshrc; echo \"Running: %s\"; %s; echo \"Press enter to close\"; read'",
    escaped_command,
    escaped_command
  )
  vim.fn.system(tmux_command)
end

-- run
vim.api.nvim_set_keymap('n', '<leader>drm', [[:lua run_dbt_for_current_buffer("dbt run -m")<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dru', [[:lua run_dbt_for_current_buffer("dbt run -m", true, false)<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>drd', [[:lua run_dbt_for_current_buffer("dbt run -m", false, true)<CR>]],
  { noremap = true, silent = true })
-- test
vim.api.nvim_set_keymap('n', '<leader>dtm', [[:lua run_dbt_for_current_buffer("dbt test -s")<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dtu', [[:lua run_dbt_for_current_buffer("dbt test -s", true, false)<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dtd', [[:lua run_dbt_for_current_buffer("dbt test -s", false, true)<CR>]],
  { noremap = true, silent = true })
-- build
vim.api.nvim_set_keymap('n', '<leader>dbm', [[:lua run_dbt_for_current_buffer("dbt build -s")<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dbu', [[:lua run_dbt_for_current_buffer("dbt build -s", true, false)<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dbd', [[:lua run_dbt_for_current_buffer("dbt build -s", false, true)<CR>]],
  { noremap = true, silent = true })

vim.keymap.set('n', '<leader>dc', open_compiled_buffer,
  { desc = "Open compiled model", noremap = true, silent = true })
vim.keymap.set('n', '<leader>da', open_run_buffer,
  { desc = "Open run model", noremap = true, silent = true })
