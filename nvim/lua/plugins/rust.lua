require("crates").setup()

-- Rebuild the identical capabilities here for rustaceanvim
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.general = capabilities.general or {}
capabilities.general.positionEncodings = { "utf-8", "utf-16" }

local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
end

-- Configure Rustaceanvim global options
vim.g.rustaceanvim = {
    tools = {
        float_win_config = {
            border = "rounded",
        },
    },
    server = {
        capabilities = capabilities, -- Pass the unified capabilities here!
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

        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
})
