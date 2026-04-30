-- lua/plugins/flash.lua

-- 1. Initialize the plugin (replaces `opts = {}`)
require("flash").setup({})

-- 2. Register the keymaps (replaces the `keys` table)
-- We localize the require call here so we don't have to type it 5 times
local flash = require("flash")

vim.keymap.set({ "n", "x", "o" }, "s", function()
    flash.jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
    flash.treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
    flash.remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function()
    flash.treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function()
    flash.toggle()
end, { desc = "Toggle Flash Search" })
