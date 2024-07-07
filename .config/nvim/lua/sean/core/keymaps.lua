-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

--------------------------------------
-- navigation ------------------------
--------------------------------------
keymap.set("n", "<S-Tab>", ":bprevious<cr>", { silent = true })
keymap.set("n", "<Tab>", ":bnext<cr>", { silent = true })

--------------------------------------
-- snippets --------------------------
--------------------------------------
-- va{ >>> visual mode select { inclusive
-- vi{ >>> visual mode select { inner
-- yi{ >>> go to start of specified character, inner
-- vaW, inclues whitespace >>> visual mode, select word + whitespace

--------------------------------------
-- general ---------------------------
--------------------------------------

-- put most recent yank
keymap.set("n", "<leader>p", '"0p', { desc = "Put most recent yank" })

-- save file
keymap.set("n", "<leader>ww", "<cmd>w<CR>", { desc = "Save file" })

-- use kj to exit insert mode
keymap.set("i", "kj", "<ESC><cmd>w<CR>", { desc = "Exit insert mode with kj" })

-- empty line insertions in normal model
keymap.set("n", "<leader><S-o>", "<S-o><ESC>", { desc = "Empty line above" })
keymap.set("n", "<leader>o", "o<ESC>", { desc = "Empty line below" })

-- clear search highlights
keymap.set("n", "<leader>h", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

--------------------------------------
-- window management -----------------
--------------------------------------

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

----------
-- TABS --
----------
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
