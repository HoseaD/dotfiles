-- lua/plugins/noice.lua

-- 1. Setup Notify first (Noice uses this as its backend)
require("notify").setup({
    -- Optional: If you use a transparent terminal background, uncomment the line below 
    -- so your notification bubbles don't look weird when overlapping text.
    -- background_colour = "#000000", 
})

-- Tell Neovim to use this new notification engine globally
vim.notify = require("notify")

-- 2. Setup Noice
require("noice").setup({
    lsp = {
        override = {
            -- Override markdown rendering so that **cmp** and other plugins use Treesitter
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
        },
    },
    -- Bring back your custom filters to hide spammy "written" messages
    routes = {
        {
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+L, %d+B" },
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },
                },
            },
            view = "mini",
        },
    },
    presets = {
        bottom_search = true, -- Uses the classic bottom cmdline for / searches
        command_palette = true, -- Positions the : command palette in the center
        long_message_to_split = true, -- Long messages will be sent to a split
        inc_rename = false, -- Set to true only if you install inc-rename.nvim
        lsp_doc_border = true, -- Adds a nice border to hover docs and signature help
    },
})

-- 3. Global Keymaps
local noice = require("noice")

vim.keymap.set("c", "<S-Enter>", function() noice.redirect(vim.fn.getcmdline()) end, { desc = "Redirect Cmdline" })
vim.keymap.set("n", "<leader>snl", function() noice.cmd("last") end, { desc = "Noice Last Message" })
vim.keymap.set("n", "<leader>snh", function() noice.cmd("history") end, { desc = "Noice History" })
vim.keymap.set("n", "<leader>sna", function() noice.cmd("all") end, { desc = "Noice All" })
vim.keymap.set("n", "<leader>snd", function() noice.cmd("dismiss") end, { desc = "Dismiss All" })

-- Use <c-f> and <c-b> to scroll inside hover documentation (like when you press K)
vim.keymap.set({"i", "n", "s"}, "<c-f>", function() 
    if not require("noice.lsp").scroll(4) then return "<c-f>" end 
end, { silent = true, expr = true, desc = "Scroll Forward" })

vim.keymap.set({"i", "n", "s"}, "<c-b>", function() 
    if not require("noice.lsp").scroll(-4) then return "<c-b>" end 
end, { silent = true, expr = true, desc = "Scroll Backward" })
