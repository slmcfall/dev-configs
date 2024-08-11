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
