-- lua/plugins/markview.lua

require("markview").setup({
    initial_state = false, -- Disables Markview by default on buffer load
})

-- Optional: Keymap to toggle it on demand
vim.keymap.set("n", "<leader>mt", "<cmd>Markview toggle<cr>", {
    desc = "[M]arkview [T]oggle",
})
