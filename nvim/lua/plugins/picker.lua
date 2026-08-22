-- lua/plugins/picker.lua

local pick = require("mini.pick")

pick.setup({
    window = {
        -- This function calculates the center of your screen dynamically
        -- and draws a floating window there with rounded borders.
        config = function()
            -- Use the Golden Ratio (0.618) to size the window beautifully relative to your terminal size
            local height = math.floor(0.618 * vim.o.lines)
            local width = math.floor(0.618 * vim.o.columns)
            return {
                anchor = "NW",
                height = height,
                width = width,
                row = math.floor(0.5 * (vim.o.lines - height)),
                col = math.floor(0.5 * (vim.o.columns - width)),
                border = "rounded",
                -- Optional: add a slight shadow/blend if your terminal supports it
                -- zindex = 150,
            }
        end,
        -- Adds a nice title to the top of the border
        prompt_prefix = "   ",
        prompt_caret = "▏",
    },
})

-- Keep mini.pick floats visually consistent with other floating windows
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "MiniPickNormal", { link = "NormalFloat" })
        vim.api.nvim_set_hl(0, "MiniPickBorder", { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "MiniPickPrompt", { link = "FloatTitle" }) -- Matches float titles
    end,
})

-- (Keep the rest of your mini.extra setup and keymaps exactly as they were below here!)
require("mini.extra").setup()

-- 3. Global keymaps for searching
vim.keymap.set("n", "<leader>ff", function()
    MiniPick.builtin.files()
end, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", function()
    MiniPick.builtin.grep()
end, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader><leader>", function()
    MiniPick.builtin.buffers()
end, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fh", function()
    MiniPick.builtin.help()
end, { desc = "[F]ind [H]elp" })
