-- lua/plugins/git_stuff.lua

-- 1. Gitsigns: inline change signs, blame and hunk operations
local gs = require("gitsigns")

gs.setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
})

local map = vim.keymap.set

-- Navigation between changes (falls through to built-in ]c/[c in diff mode)
vim.keymap.set("n", "]c", function()
    if vim.wo.diff then return "]c" end
    vim.schedule(gs.next_hunk)
    return "<Ignore>"
end, { expr = true, desc = "Next [C]hange" })

vim.keymap.set("n", "[c", function()
    if vim.wo.diff then return "[c" end
    vim.schedule(gs.prev_hunk)
    return "<Ignore>"
end, { expr = true, desc = "Previous [C]hange" })

-- Preview & blame
map("n", "<leader>ci", gs.preview_hunk_inline, { desc = "[C]hanges [I]nline preview" })
map("n", "<leader>cp", gs.preview_hunk, { desc = "[C]hanges [P]review (float)" })
map("n", "<leader>cb", function()
    gs.blame_line({ full = true })
end, { desc = "[C]hanges [B]lame line" })
map("n", "<leader>cB", gs.blame, { desc = "[C]hanges full-file [B]lame" })

-- Stage / reset
map({ "n", "v" }, "<leader>cs", gs.stage_hunk, { desc = "[C]hanges [S]tage hunk" })
map("n", "<leader>cS", gs.stage_buffer, { desc = "[C]hanges stage buffer" })
map("n", "<leader>cu", gs.undo_stage_hunk, { desc = "[C]hanges [U]ndo stage" })
map({ "n", "v" }, "<leader>cr", gs.reset_hunk, { desc = "[C]hanges [R]eset hunk" })
map("n", "<leader>cR", gs.reset_buffer, { desc = "[C]hanges reset buffer" })

-- Diffs
map("n", "<leader>cd", gs.diffthis, { desc = "[C]hanges [D]iff vs index" })
map("n", "<leader>cD", function()
    gs.diffthis("~")
end, { desc = "[C]hanges diff vs HEAD~" })

-- 2. Diffview: changed-file tree + per-file diffs, file/repo history
require("diffview").setup({})

map("n", "<leader>cv", "<cmd>DiffviewOpen<cr>", { desc = "[C]hanges [V]iew (working copy)" })
map("n", "<leader>cx", "<cmd>DiffviewClose<cr>", { desc = "[C]hanges e[X]it view" })
map("n", "<leader>cf", "<cmd>DiffviewFileHistory %<cr>", { desc = "[C]hanges [F]ile history" })
map("n", "<leader>cL", "<cmd>DiffviewFileHistory<cr>", { desc = "[C]hanges repo [L]og" })

-- 3. hunk.nvim: interactive diff-editor invoked by jj split/squash/commit -i
-- (wired up via ui.diff-editor in ~/.config/jj/config.toml)
require("hunk").setup({})

-- 4. Jujutsu: :J <subcommand> passthrough wrappers
local jj_cmd = require("jj.cmd").j

map("n", "<leader>jd", function()
    jj_cmd({ "describe" })
end, { desc = "[J]ujutsu [D]escribe" })
map("n", "<leader>jn", function()
    jj_cmd({ "new" })
end, { desc = "[J]ujutsu [N]ew change" })
map("n", "<leader>js", function()
    jj_cmd({ "split" })
end, { desc = "[J]ujutsu [S]plit (interactive)" })
map("n", "<leader>jl", function()
    jj_cmd({ "log" })
end, { desc = "[J]ujutsu [L]og" })
map("n", "<leader>ju", function()
    jj_cmd({ "undo" })
end, { desc = "[J]ujutsu [U]ndo" })
map("n", "<leader>jst", function()
    jj_cmd({ "status" })
end, { desc = "[J]ujutsu status" })
