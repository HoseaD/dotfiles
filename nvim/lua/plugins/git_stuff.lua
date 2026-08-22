-- lua/plugins/git_stuff.lua

-- 1. Gitsigns: inline change signs, blame and hunk operations
local gs = require("gitsigns")

local map = vim.keymap.set

gs.setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
    -- Keymaps are buffer-local so they only exist where gitsigns is attached
    on_attach = function(bufnr)
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation between changes (falls through to built-in ]c/[c in diff mode)
        vim.keymap.set("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(gs.next_hunk)
            return "<Ignore>"
        end, { buffer = bufnr, expr = true, desc = "Next [C]hange" })
        vim.keymap.set("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(gs.prev_hunk)
            return "<Ignore>"
        end, { buffer = bufnr, expr = true, desc = "Previous [C]hange" })

        -- Preview & blame
        map("n", "<leader>ci", gs.preview_hunk_inline, "[C]hanges [I]nline preview")
        map("n", "<leader>cp", gs.preview_hunk, "[C]hanges [P]review (float)")
        map("n", "<leader>cb", function()
            gs.blame_line({ full = true })
        end, "[C]hanges [B]lame line")
        map("n", "<leader>cB", gs.blame, "[C]hanges full-file [B]lame")

        -- Stage / reset
        map({ "n", "v" }, "<leader>cs", gs.stage_hunk, "[C]hanges [S]tage hunk")
        map("n", "<leader>cS", gs.stage_buffer, "[C]hanges stage buffer")
        map("n", "<leader>cu", gs.undo_stage_hunk, "[C]hanges [U]ndo stage")
        map({ "n", "v" }, "<leader>cr", gs.reset_hunk, "[C]hanges [R]eset hunk")
        map("n", "<leader>cR", gs.reset_buffer, "[C]hanges reset buffer")
    end,
})

-- Diff sessions (`<leader>cd`/`cD`): press `q` anywhere to restore state
local function diffthis(base)
    local orig_win = vim.api.nvim_get_current_win()
    local orig_buf = vim.api.nvim_get_current_buf()

    gs.diffthis(base, nil, vim.schedule_wrap(function()
        if not vim.api.nvim_buf_is_valid(orig_buf) then
            return
        end

        local qbufs = {}
        local function close_diff()
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                pcall(function()
                    vim.wo[win].diff = false
                end)
            end
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
                if name:find("^gitsigns://") and win ~= orig_win then
                    pcall(vim.api.nvim_win_close, win, true)
                end
            end
            for _, buf in ipairs(qbufs) do
                pcall(vim.keymap.del, "n", "q", { buffer = buf })
            end
            if vim.api.nvim_win_is_valid(orig_win) then
                vim.api.nvim_set_current_win(orig_win)
            end
        end

        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.wo[win].diff then
                local buf = vim.api.nvim_win_get_buf(win)
                qbufs[#qbufs + 1] = buf
                vim.keymap.set("n", "q", close_diff, { buffer = buf, desc = "[C]hanges exit diff" })
            end
        end
    end))
end

map("n", "<leader>cd", function()
    diffthis()
end, { desc = "[C]hanges [D]iff vs index" })
map("n", "<leader>cD", function()
    diffthis("~")
end, { desc = "[C]hanges diff vs HEAD~" })

-- Safety net: if either side of a gitsigns diff session is closed manually
-- (`:q`, `<C-w>c`), make sure no window stays stuck in diff mode.
vim.api.nvim_create_autocmd("WinClosed", {
    group = vim.api.nvim_create_augroup("gitsigns-diff-cleanup", { clear = true }),
    pattern = "gitsigns://*",
    nested = true,
    callback = function()
        vim.schedule(function()
            local names = {}
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                names[vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))] = win
            end
            -- Only sweep when no gitsigns buffer remains in this tabpage
            if next(vim.tbl_filter(function(n)
                return n:find("^gitsigns://") ~= nil
            end, vim.tbl_keys(names))) then
                return
            end
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                pcall(function()
                    vim.wo[win].diff = false
                end)
            end
        end)
    end,
})

-- Generic fallback: any diff-mode window without its own `q` binding (e.g. a
-- manual `:diffsplit`) gets one that clears every diff flag in the tabpage and
-- closes auxiliary virtual-buffer windows. Skipped for buffers that already map
-- `q` (gitsigns wrapper, diffview, hunk.nvim).
local function has_local_q(bufnr)
    for _, m in ipairs(vim.api.nvim_buf_get_keymap(bufnr, "n")) do
        if m.lhs == "q" then
            return true
        end
    end
    return false
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("diff-exit-q", { clear = true }),
    callback = function()
        vim.schedule(function()
            if not vim.wo.diff or has_local_q(0) or vim.fn.maparg("q", "n") ~= "" then
                return
            end
            -- leave plugin-managed surfaces alone (their own q mounts late)
            local name = vim.api.nvim_buf_get_name(0)
            if name:find("^diffview://") or name:find("^gitsigns://") then
                return
            end
            vim.keymap.set("n", "q", function()
                for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                    pcall(function()
                        vim.wo[win].diff = false
                    end)
                end
                local cur = vim.api.nvim_get_current_win()
                for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                    local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
                    if win ~= cur and (name:find("^gitsigns://") or name:find("^fugitive://")) then
                        pcall(vim.api.nvim_win_close, win, true)
                    end
                end
                -- drop this fallback once used; the session is over
                pcall(vim.keymap.del, "n", "q", { buffer = 0 })
            end, { buffer = 0, desc = "[C]hanges exit diff" })
        end)
    end,
})

-- 2. Diffview: changed-file tree + per-file diffs, file/repo history
-- `q` exits the whole view from anywhere (upstream's actions.close would only
-- hide the panel when it has focus).
local function diffview_quit()
    local lib = require("diffview.lib")
    local view = lib.get_current_view()
    if view then
        view:close()
    end
end

require("diffview").setup({
    keymaps = {
        view = {
            { "n", "q", diffview_quit, { desc = "Close the diff view" } },
        },
        file_panel = {
            { "n", "q", diffview_quit, { desc = "Close the diff view" } },
        },
        file_history_panel = {
            { "n", "q", diffview_quit, { desc = "Close the diff view" } },
        },
    },
})

vim.keymap.set("n", "<leader>cv", "<cmd>DiffviewOpen<cr>", { desc = "[C]hanges [V]iew (working copy)" })
vim.keymap.set("n", "<leader>cx", "<cmd>DiffviewClose<cr>", { desc = "[C]hanges e[X]it view" })
vim.keymap.set("n", "<leader>cf", "<cmd>DiffviewFileHistory %<cr>", { desc = "[C]hanges [F]ile history" })
vim.keymap.set("n", "<leader>cL", "<cmd>DiffviewFileHistory<cr>", { desc = "[C]hanges repo [L]og" })

-- 3. hunk.nvim: interactive diff-editor invoked by jj split/squash/commit -i
-- (wired up via ui.diff-editor in ~/.config/jj/config.toml)
require("hunk").setup({})

-- 4. Jujutsu: :J <subcommand> passthrough wrappers
require("jj").setup({})
local jj_cmd = require("jj.cmd").j

vim.keymap.set("n", "<leader>jd", function()
    jj_cmd({ "describe" })
end, { desc = "[J]ujutsu [D]escribe" })
vim.keymap.set("n", "<leader>jn", function()
    jj_cmd({ "new" })
end, { desc = "[J]ujutsu [N]ew change" })
vim.keymap.set("n", "<leader>js", function()
    jj_cmd({ "split" })
end, { desc = "[J]ujutsu [S]plit (interactive)" })
vim.keymap.set("n", "<leader>jl", function()
    jj_cmd({ "log" })
end, { desc = "[J]ujutsu [L]og" })
vim.keymap.set("n", "<leader>ju", function()
    jj_cmd({ "undo" })
end, { desc = "[J]ujutsu [U]ndo" })
vim.keymap.set("n", "<leader>jt", function()
    jj_cmd({ "status" })
end, { desc = "[J]ujutsu s[T]atus" })
