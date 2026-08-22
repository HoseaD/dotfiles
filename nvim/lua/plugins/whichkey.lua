-- lua/plugins/whichkey.lua

-- 1. Which-key relies on Neovim's built-in timeout settings to know when to pop up.
-- (You might already have these in your config/options.lua, but it's safe to ensure they are set here!)
vim.o.timeout = true
vim.o.timeoutlen = 300

-- 2. Call the setup function
local wk = require("which-key")

wk.setup({
    preset = "modern", -- Options: "classic", "modern", "helix"
    win = {
        border = "rounded", -- Makes the popup look much cleaner
        padding = { 1, 2 }, -- extra space inside the window
        title = true,
        title_pos = "center",
    },
    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
    },
    layout = {
        align = "center", -- Better readability for long lists
    },
})

-- 3. Register your key groups (if you have them)
-- Note: which-key v3 (the current version) modernized how you register groups.
-- It now uses wk.add() instead of the old wk.register().
wk.add({
    { "<leader>f", group = "[F]ind / File" },
    { "<leader>g", group = "[G]it" },
    { "<leader>w", group = "[W]orkspace" },
    { "<leader>t", group = "[T]ests / Coverage" },
    { "z", group = "[Z]folding" },
    { "[", group = "prev", icon = " " },
    { "]", group = "next", icon = " " },
})
