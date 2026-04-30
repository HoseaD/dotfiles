-- lua/plugins/git_stuff.lua

-- 1. Gitsigns
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
})

vim.keymap.set("n", "<leader>gg", function()
    require("gitsigns").preview_hunk_inline()
end, { desc = "[H]unk [I]nline Preview" })

-- Navigation: Next/Previous Change
vim.keymap.set("n", "]g", function()
    require("gitsigns").next_hunk()
end, { desc = "Next Git [H]unk" })

vim.keymap.set("n", "[g", function()
    require("gitsigns").prev_hunk()
end, { desc = "Previous Git [H]unk" })

-- 2. Neogit
-- Neogit requires a setup call. It will automatically detect mini.pick
-- and diffview since we installed them!
require("neogit").setup({})

-- 3. Lazygit
-- Lazygit doesn't strictly require a Lua setup call to work, just the keymap.
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- 4. Jujutsu (jj)
require("jj").setup({})

-- jj-diffconflicts is just a standard Vim plugin that loads its own logic automatically,
-- so it doesn't need any explicit setup here.
