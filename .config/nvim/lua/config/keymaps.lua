-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Setup alternative ESC keys
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("i", "kj", "<Esc>", { noremap = true, silent = true })

-- Setup alternative COMMND key
vim.keymap.set("n", "<SPACE>;", ":", { noremap = true, silent = true, desc = "Alternative cmdline" })

-- Setup alternative QUIT key
vim.keymap.set("c", "qq", "q!", { noremap = true, silent = true, desc = "Alternative forced quit" })

-- Disable default 'q' to prevent accidental macro recording; remap 'Q' to toggle instead.
vim.keymap.set("n", "q", "<nop>", { noremap = true, silent = true }) -- Disable original 'q' mapping
vim.keymap.set("n", "Q", "q", { noremap = true, desc = "Start/Stop Macro Recording" }) -- Map 'Q' to 'q'

-- Setup a next buffer sub-command
-- vim.keymap.set("n", "<LEADER>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<LEADER>bn", ":enew<CR>", { noremap = true, desc = "New Buffer" })
