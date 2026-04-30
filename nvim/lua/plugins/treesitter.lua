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
})

-- 2. Enable Highlighting and Indentation natively
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter-startup", { clear = true }),
    pattern = "*",
    callback = function(event)
        -- Safely start treesitter highlighting (pcall prevents errors on unsupported files)
        pcall(vim.treesitter.start, event.buf)

        -- Enable treesitter-based indentation
        vim.bo[event.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"

        -- Optional: Enable treesitter-based code folding
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
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
