-------------------------------------------------------------------------------
-- 1. STATUSLINE (With Custom Word Count)
-------------------------------------------------------------------------------
local statusline = require("mini.statusline")

statusline.setup({
    content = {
        active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git = statusline.section_git({ trunc_width = 40 })
            local diff = statusline.section_diff({ trunc_width = 75 })
            local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
            local lsp = statusline.section_lsp({ trunc_width = 75 })
            local filename = statusline.section_filename({ trunc_width = 140 })
            local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
            local location = statusline.section_location({ trunc_width = 75 })
            local search = statusline.section_searchcount({ trunc_width = 75 })

            -- Your custom word count logic!
            local wc = vim.fn.wordcount()
            local word_count = ""
            if vim.fn.mode() == "v" or vim.fn.mode() == "\22" then
                word_count = wc.visual_words == 1 and wc.visual_words .. " word" or wc.visual_words .. " words"
            else
                word_count = wc.words .. " words"
            end

            -- Construct the actual statusline
            return statusline.combine_groups({
                { hl = mode_hl, strings = { mode } },
                { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
                "%<", -- Mark general truncate point
                { hl = "MiniStatuslineFilename", strings = { filename } },
                "%=", -- End left alignment

                -- Injecting the word count right before the file info
                { hl = "MiniStatuslineFileinfo", strings = { word_count } },
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                { hl = mode_hl, strings = { search, location } },
            })
        end,
    },
})

-------------------------------------------------------------------------------
-- 2. INDENT SCOPE
-------------------------------------------------------------------------------
require("mini.indentscope").setup({
    symbol = "│",
    options = { try_as_border = true },
})

-- Disable indentscope for certain filetypes so it doesn't draw lines in file explorers
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "neo-tree", "lazygit", "fidget", "mason" },
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})

-------------------------------------------------------------------------------
-- 3. UI DRESSING
-------------------------------------------------------------------------------
require("dressing").setup({
    input = {
        insert_only = false,
        border = "rounded",
    },
    select = {
        -- Automatically routes vim.ui.select through your mini.pick interface!
        backend = { "mini.pick", "builtin" },
    },
})
