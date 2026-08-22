-- lua/plugins/treesitter.lua

-- 1. Install parsers (Replaces `ensure_installed` and `auto_install`)
require("nvim-treesitter").install({
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "bash",
    "rust",
    "latex",
    "typst",
})

-- 2. Enable Highlighting and Indentation natively
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter-startup", { clear = true }),
    pattern = "*",
    callback = function(event)
        -- Skip heavy features for buffers flagged by the BigFileGuard autocmd
        if vim.b[event.buf].is_large_file then
            return
        end

        -- Safely start treesitter highlighting; skip indentation/folding when
        -- no parser is available for this filetype
        local ok = pcall(vim.treesitter.start, event.buf)
        if not ok then
            return
        end

        -- Enable treesitter-based indentation
        vim.bo[event.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end,
})

-- 3. Configure Treesitter Text Objects independently
require("nvim-treesitter-textobjects").setup({
    select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj
        keymaps = {
            ["af"] = { query = "@function.outer", desc = "Select [A]round [F]unction" },
            ["if"] = { query = "@function.inner", desc = "Select [I]nside [F]unction" },
            ["ac"] = { query = "@class.outer", desc = "Select [A]round [C]lass" },
            ["ic"] = { query = "@class.inner", desc = "Select [I]nside [C]lass" },
        },
    },
    move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
        },
        goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
        },
    },
})
