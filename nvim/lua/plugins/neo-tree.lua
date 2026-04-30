-- 1. Disable netrw (This replaces the bottom of your Lazy 'init' function)
-- It's best practice to do this before requiring neo-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 2. Global Keymaps (This replaces the Lazy 'keys' table)
vim.keymap.set("n", "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal", silent = true })

-- 3. The Directory Check (This replaces the top of your Lazy 'init' function)
-- Note: In Neovim 0.10+, `vim.loop` was renamed to `vim.uv`. Since you are on 0.12,
-- we should use the modern syntax!
local hijack_behavior = "open_default"

if vim.fn.argc(-1) == 1 then
    local stat = vim.uv.fs_stat(vim.fn.argv(0)) -- Updated to vim.uv
    if stat and stat.type == "directory" then
        hijack_behavior = "open_current"
    end
end

-- 4. The Setup (This replaces the Lazy 'opts' table)
require("neo-tree").setup({
    filesystem = {
        hijack_netrw_behavior = hijack_behavior,
        window = {
            mappings = {
                ["\\"] = "close_window",
            },
        },
    },
})
