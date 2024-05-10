local map = vim.keymap.set

-- Map leader to <space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Exit Insert mode with jk
map("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

map("n", "<leader>e", vim.cmd.NvimTreeToggle)

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
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = "Move focus to the left window from terminal" })
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = "Move focus to the lower window from terminal" })
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = "Move focus to the upper window from terminal" })
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = "Move focus to the right window from terminal" })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ToggleTerm Keymaps
map("n", "<leader>tt", vim.cmd.ToggleTerm, { desc = "Open ToggleTerm"})
map("n", "<leader>tf", '<cmd>lua OpenFloatTermAndDisableSpell("float")<CR>', { desc = "Open ToggleTerm Float"})
map("n", "<leader>tv", '<cmd>lua OpenFloatTermAndDisableSpell("vertical")<CR>', { desc = "Open ToggleTerm Float"})
map("n", "<leader>th", '<cmd>lua OpenFloatTermAndDisableSpell("horizontal")<CR>', { desc = "Open ToggleTerm Float"})

map("n", "<leader>ll", vim.cmd.ToggleTermSendCurrentLine, {desc = "send_lines_to_terminal"})
map("n", "<leader>lv", vim.cmd.ToggleTermSendVisualLines, {desc = "send_lines_to_terminal"})
map("n", "<leader>ls", vim.cmd.ToggleTermSendVisualSelection, {desc = "send_lines_to_terminal"})

function OpenFloatTermAndDisableSpell(direction)
    -- Toggle the floating terminal
    vim.cmd("ToggleTerm direction=" ..direction)

    -- Disable spell checking in the current window
    vim.wo.spell = false
end
