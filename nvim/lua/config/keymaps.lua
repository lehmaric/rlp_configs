-- ==============================================================================
-- KEYMAPS
-- ==============================================================================

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General quality of life
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Return to File Explorer" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

