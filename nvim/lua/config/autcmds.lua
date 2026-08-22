-- Create an augroup for the large file guard
local big_file_group = vim.api.nvim_create_augroup("BigFileGuard", { clear = true })

vim.api.nvim_create_autocmd("BufReadPre", {
    group = big_file_group,
    pattern = "*",
    callback = function(event)
        local buf = event.buf
        local filepath = event.match
        local max_filesize = 1024 * 1024 -- 1 MB (Adjust this threshold as needed)

        -- Stat the file to get its size in bytes
        local ok, stats = pcall(vim.uv.fs_stat, filepath)

        if ok and stats and stats.size > max_filesize then
            -- 1. Set a global flag on this buffer so other plugins know it's a big file
            vim.b[buf].is_large_file = true

            -- 2. Disable heavy buffer-local features BEFORE reading
            vim.bo[buf].swapfile = false -- Prevents writing massive swap files to disk
            vim.bo[buf].undofile = false -- Disables undo file history for this session

            -- Disable legacy regex syntax highlighting just in case Treesitter isn't handling it
            vim.bo[buf].syntax = ""

            -- 3. Defer window-local options until the buffer is actually rendered
            vim.schedule(function()
                if vim.api.nvim_buf_is_valid(buf) then
                    vim.opt_local.wrap = false -- Wrapping long lines is incredibly slow
                    vim.opt_local.foldenable = false -- Disable folding entirely
                    vim.opt_local.spell = false -- Disable spellchecking
                end
            end)

            -- Notify the user (formats the bytes into MB for readability)
            local mb_size = stats.size / (1024 * 1024)
            vim.notify(
                string.format("Large file detected (%.2f MB). Performance guard activated.", mb_size),
                vim.log.levels.WARN
            )
        end
    end,
})
