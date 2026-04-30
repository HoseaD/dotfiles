vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
-- Exit Insert mode with jk
-- map("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Terminal mode mappings to switch windows
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Move focus to the left window from terminal" })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Move focus to the lower window from terminal" })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Move focus to the upper window from terminal" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Move focus to the right window from terminal" })

-- Diagnostic keymaps
map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end)
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end)

map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]Error messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
