require("crates").setup()

-- Reuse the shared capabilities (blink.cmp + utf-8 position encoding)
vim.g.rustaceanvim = {
    tools = {
        float_win_config = {
            border = "rounded",
        },
    },
    server = {
        capabilities = require("config.capabilities"), -- Pass the unified capabilities here!
        default_settings = {
            ["rust-analyzer"] = {
                checkOnSave = true,
                check = {
                    command = "clippy",
                },
            },
        },
    },
}

-- Rust-specific Keymaps & Auto-formatting
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("rust-custom-setup", { clear = true }),
    pattern = "rust",
    callback = function(event)
        local bufnr = event.buf

        vim.keymap.set(
            "n",
            "<Leader>dt",
            "<cmd>RustLsp testables<CR>",
            { buffer = bufnr, desc = "Rust: [D]ebugger [T]estables" }
        )
        vim.keymap.set(
            "n",
            "<Leader>dr",
            "<cmd>RustLsp runnables<CR>",
            { buffer = bufnr, desc = "Rust: [D]ebugger [R]unnables" }
        )
        vim.keymap.set(
            "n",
            "<Leader>em",
            "<cmd>RustLsp expandMacro<CR>",
            { buffer = bufnr, desc = "Rust: [E]xpand [M]acro" }
        )

        -- Formatting is handled by conform's format_on_save (lsp_format fallback)
    end,
})
