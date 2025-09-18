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

map("t", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("t", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("t", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("t", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Terminal mode mappings to switch windows
map('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = "Move focus to the left window from terminal" })
map('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = "Move focus to the lower window from terminal" })
map('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = "Move focus to the upper window from terminal" })
map('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = "Move focus to the right window from terminal" })

-- Diagnostic keymaps
map('n', '[d', function() vim.diagnostic.jump({count= -1,float = true}) end)
map('n', ']d', function() vim.diagnostic.jump({count= 1,float = true}) end)


map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]Error messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })


-- rustaceanvim
-- map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
-- map("n", "<Leader>dm", "<cmd>lua vim.cmd('RustLsp runnables')<CR>", {desc = "Rust Runables"})

map('n', '<leader>fu', ':lua require("telescope.builtin").lsp_references()<CR>', { noremap = true, silent = true, desc = "Show usage in telescope"})
