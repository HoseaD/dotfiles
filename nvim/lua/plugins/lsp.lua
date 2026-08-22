-- 1. Setup standalone UI
require("fidget").setup({})

-- lua/plugins/lsp.lua

-- Float borders are handled globally by `vim.o.winborder` (see config/options.lua)

-- 2. Define your LSP Keymaps & Autocmds
-- (This stays exactly the same as before using LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Replace the old Telescope mappings with mini.extra LSP pickers
        map("gd", function()
            require("mini.extra").pickers.lsp({ scope = "definition" })
        end, "[G]oto [D]efinition")

        map("gr", function()
            require("mini.extra").pickers.lsp({ scope = "references" })
        end, "[G]oto [R]eferences")

        map("gI", function()
            require("mini.extra").pickers.lsp({ scope = "implementation" })
        end, "[G]oto [I]mplementation")

        map("<leader>D", function()
            require("mini.extra").pickers.lsp({ scope = "type_definition" })
        end, "Type [D]efinition")

        map("<leader>ds", function()
            require("mini.extra").pickers.lsp({ scope = "document_symbol" })
        end, "[D]ocument [S]ymbols")

        map("<leader>ws", function()
            require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
        end, "[W]orkspace [S]ymbols")

        map("K", vim.lsp.buf.hover, "Hover Documentation")

        map("<leader>rn", vim.lsp.buf.rename, "Rename")
    end,
})

-- 3. Define Capabilities (shared with other LSP consumers via config.capabilities)
local capabilities = require("config.capabilities")

-- 4. Configure specific servers using the NEW native API
-- You only need to call this for servers where you are overriding default settings.
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enabled = false },
            diagnostics = { disable = { "missing-fields" }, globals = { "vim" } },
        },
    },
})

vim.lsp.config("texlab", {
    capabilities = capabilities,
    settings = { texlab = {} },
})

vim.lsp.config("tinymist", {
    capabilities = capabilities,
    settings = {
        exportPdf = "onSave",
        formatterMode = "typstyle",
    },
})

-- For servers that just need standard capabilities with no custom settings:
vim.lsp.config("clangd", { capabilities = capabilities })
vim.lsp.config("typos_lsp", { capabilities = capabilities })

-- 5. Boot up Mason
require("mason").setup()

require("mason-tool-installer").setup({
    ensure_installed = {
        "lua_ls",
        "clangd",
        "typos_lsp",
        "texlab",
        "stylua",
        "tinymist",
        "typstyle",
    },
})

require("mason-lspconfig").setup({
    -- Mason-lspconfig will now automatically detect installed servers
    -- and enable them under the hood using Neovim's native vim.lsp.enable().
    -- No more handlers table needed!
})
