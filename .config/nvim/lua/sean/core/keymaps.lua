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
keymap.set("n", "<leader>p", '"0p', { desc = "Put most recent yank" })

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

keymap.set("n", "ycc", "yygccp", { desc = "comment + duplicate line", remap = true })

keymap.set("x", "/", "<Esc>/\\%V", { desc = "search only visual selection" })

-- Swap Ctrl+I and Ctrl+O (jump list navigation)
keymap.set("n", "<C-i>", "<C-o>", { noremap = true, desc = "Jump backward (swapped)" })
keymap.set("n", "<C-o>", "<C-i>", { noremap = true, desc = "Jump forward (swapped)" })

-------------
-- BUFFERS --
-------------
keymap.set("n", "<leader>bb", "<cmd>b#<CR>", { desc = "Navigate to last accessed buffer" })

keymap.set('n', '<leader>ya', 'mzggVGy`z',
  { desc = "yank entire buffer, return cursor to original position", noremap = true, silent = true })

------------
-- SPLITS --
------------
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
keymap.set("n", "<leader>ae", "<C-V>lllllljjxA<BS><ESC>jA<BS><ESC><cmd>w<CR><ESC>", { desc = "Format aws env var creds" })



----------
-- dbt --
----------
-- read a top-level scalar (e.g. `name`, `target-path`) from dbt_project.yml
local function dbt_project_value(root, key)
  local ok, lines = pcall(vim.fn.readfile, root .. "/dbt_project.yml")
  if not ok then return nil end
  for _, line in ipairs(lines) do
    line = line:gsub("%s+#.*$", "")
    local value = line:match("^" .. vim.pesc(key) .. ":%s*['\"]?([^'\"]-)['\"]?%s*$")
    if value and value ~= "" then return value end
  end
end

-- open the compiled/run version of the current model, or jump back to the source
-- when already in one. target files live at:
--   <project>/<target-path>/<kind>/<package name>/<path relative to the package>
local function open_dbt_target_file(kind)
  local file = vim.api.nvim_buf_get_name(0)
  -- search from the file path, not the buffer: vim.fs.root(0) falls back to cwd for
  -- buffers with a buftype (dbtpal marks compiled files buftype=nowrite)
  local root = file ~= "" and vim.fs.root(file, "dbt_project.yml")
  if not root then
    vim.notify("Not in a dbt project", vim.log.levels.WARN)
    return
  end

  -- models from installed packages compile into the outer project's target dir
  local project = root:match("^(.*)/dbt_packages/[^/]+$") or root
  local target = vim.env.DBT_TARGET_PATH or dbt_project_value(project, "target-path") or "target"
  if not vim.startswith(target, "/") then target = project .. "/" .. target end

  local path
  local in_target = file:sub(1, #target + 1) == target .. "/" and file:sub(#target + 2)
  if in_target then
    -- compiled/<pkg>/<rel> or run/<pkg>/<rel> -> source file
    local pkg, rel = in_target:match("^[^/]+/([^/]+)/(.+)$")
    if not pkg then return end
    local own = dbt_project_value(project, "name")
    path = (pkg == own and project or project .. "/dbt_packages/" .. pkg) .. "/" .. rel
  else
    local name = dbt_project_value(root, "name")
    if not name then
      vim.notify("Couldn't read `name` from " .. root .. "/dbt_project.yml", vim.log.levels.WARN)
      return
    end
    path = table.concat({ target, kind, name, file:sub(#root + 2) }, "/")
  end

  if vim.fn.filereadable(path) == 0 then
    local hint = in_target and "" or (kind == "run" and " (run `dbt run` first)" or " (run `dbt compile` first)")
    vim.notify("Not found: " .. vim.fn.fnamemodify(path, ":~:.") .. hint, vim.log.levels.WARN)
    return
  end

  -- reuse a window already showing the file
  local win = vim.fn.bufwinid(vim.fn.bufnr(path))
  if win ~= -1 then
    vim.api.nvim_set_current_win(win)
  else
    vim.cmd("vsplit " .. vim.fn.fnameescape(path))
  end
end

function _G.run_dbt_for_current_buffer(dbt_run_command, upstream, downstream)
  dbt_run_command = dbt_run_command or "dbt run -s"
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

  -- shellescape: file/dir names must never be interpreted by the shell
  local dbt_command = string.format('cd %s && clear && poetry run %s %s --profiles-dir %s',
    vim.fn.shellescape(buffer_dir), dbt_run_command, vim.fn.shellescape(model_name), vim.fn.shellescape(buffer_dir))
  local escaped_command = dbt_command:gsub("'", "'\\''")
  local tmux_command = string.format(
    "tmux popup 'source ~/.zshrc; %s; echo \"Press Ctrl+c to close\"; read'",
    escaped_command
  )
  vim.fn.system(tmux_command)
end

-- run
vim.api.nvim_set_keymap('n', '<leader>drm', [[:lua run_dbt_for_current_buffer("dbt run -s")<CR>]],
  { noremap = true, silent = true, desc = "model" })
vim.api.nvim_set_keymap('n', '<leader>dru', [[:lua run_dbt_for_current_buffer("dbt run -s", true, false)<CR>]],
  { noremap = true, silent = true, desc = "model + upstream" })
vim.api.nvim_set_keymap('n', '<leader>drd', [[:lua run_dbt_for_current_buffer("dbt run -s", false, true)<CR>]],
  { noremap = true, silent = true, desc = "model + downstream" })
-- test
vim.api.nvim_set_keymap('n', '<leader>dtm', [[:lua run_dbt_for_current_buffer("dbt test -s")<CR>]],
  { noremap = true, silent = true, desc = "model" })
vim.api.nvim_set_keymap('n', '<leader>dtu', [[:lua run_dbt_for_current_buffer("dbt test -s", true, false)<CR>]],
  { noremap = true, silent = true, desc = "model + upstream" })
vim.api.nvim_set_keymap('n', '<leader>dtd', [[:lua run_dbt_for_current_buffer("dbt test -s", false, true)<CR>]],
  { noremap = true, silent = true, desc = "model + downstream" })
-- build
vim.api.nvim_set_keymap('n', '<leader>dbm', [[:lua run_dbt_for_current_buffer("dbt build -s")<CR>]],
  { noremap = true, silent = true, desc = "model" })
vim.api.nvim_set_keymap('n', '<leader>dbu', [[:lua run_dbt_for_current_buffer("dbt build -s", true, false)<CR>]],
  { noremap = true, silent = true, desc = "model + upstream" })
vim.api.nvim_set_keymap('n', '<leader>dbd', [[:lua run_dbt_for_current_buffer("dbt build -s", false, true)<CR>]],
  { noremap = true, silent = true, desc = "model + downstream" })

vim.keymap.set('n', '<leader>dc', function() open_dbt_target_file("compiled") end,
  { desc = "Open compiled model (or back to source)", noremap = true, silent = true })
vim.keymap.set('n', '<leader>da', function() open_dbt_target_file("run") end,
  { desc = "Open run model (or back to source)", noremap = true, silent = true })


------
--- sqlfluff
---
function _G.run_sqlfluff_for_current_buffer(sqlfluff_run_command, on_directory)
  sqlfluff_run_command = sqlfluff_run_command or "sqlfluff lint"
  -- the current file, or its directory
  local model_name = vim.fn.expand(on_directory and '%:p:h' or '%:p')
  local buffer_dir = vim.fn.getcwd()

  -- shellescape: file/dir names must never be interpreted by the shell
  local sqlfluff_command = string.format('cd %s && poetry run %s %s -v', vim.fn.shellescape(buffer_dir),
    sqlfluff_run_command, vim.fn.shellescape(model_name))
  local escaped_command = sqlfluff_command:gsub("'", "'\\''")
  local escaped_echo = vim.fn.shellescape("Running: " .. sqlfluff_command):gsub("'", "'\\''")
  local tmux_command = string.format(
    "tmux popup 'source ~/.zshrc; echo %s; %s; echo \"Press Ctrl+c to close\"; read'",
    escaped_echo,
    escaped_command
  )
  vim.fn.system(tmux_command)
end

vim.api.nvim_set_keymap('n', '<leader>dslf', [[:lua run_sqlfluff_for_current_buffer("sqlfluff lint", false)<CR>]],
  { noremap = true, silent = true, desc = "sqlfluff lint" })

vim.api.nvim_set_keymap('n', '<leader>dsld', [[:lua run_sqlfluff_for_current_buffer("sqlfluff lint", true)<CR>]],
  { noremap = true, silent = true, desc = "sqlfluff lint current directory" })

vim.api.nvim_set_keymap('n', '<leader>dsff', [[:lua run_sqlfluff_for_current_buffer("sqlfluff fix", false)<CR>]],
  { noremap = true, silent = true, desc = "sqlfluff fix" })

vim.api.nvim_set_keymap('n', '<leader>dsfd', [[:lua run_sqlfluff_for_current_buffer("sqlfluff fix", true)<CR>]],
  { noremap = true, silent = true, desc = "sqlfluff fix current directory" })
