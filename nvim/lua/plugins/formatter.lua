require("conform").setup({
    -- Map your filetypes to the formatters you installed via Mason
    formatters_by_ft = {
        lua = { "stylua" },
        tex = { "tex-fmt" },
        json = { "prettier" },
        jsonc = { "prettier" },
        toml = { "taplo" },
        markdown = { "prettier" },
        python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
        -- Examples for when you expand your workflow:
        -- python = { "isort", "black" },
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    formatters = {
        ["tex-fmt"] = {
            prepend_args = { "--wraplen", "100" },
        },
        prettier = {
            prepend_args = { "--prose-wrap", "always", "--print-width", "100" },
        },
    },

    format_on_save = {
        timeout_ms = 5000,
        lsp_format = "fallback",
    },
})

-- Optional: A manual keymap just in case you want to format without saving
vim.keymap.set({ "n", "v" }, "<leader>fm", function()
    require("conform").format({ lsp_format = "fallback", timeout_ms = 5000 })
end, { desc = "[F]or[M]at buffer" })
