return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            tex = { "tex-fmt" },
        },
        formatters = {
            ["tex-fmt"] = {
                prepend_args = { "-l", "100"},
            },
        },
        -- Optional: Format on save
        -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
    keys = {
        {
            "<leader>ff", -- Wir überschreiben dein bisheriges Mapping
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
}
