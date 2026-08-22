-- lua/plugins/typst.lua

-- 1. Shared helper to resolve the main entrypoint
local function get_main_file(path_of_buffer)
    local root = vim.fs.root(path_of_buffer, { ".git", "typst.toml" })
    if root and vim.fn.filereadable(root .. "/main.typ") == 1 then
        return root .. "/main.typ"
    end
    return path_of_buffer
end

-- 2. Setup Typst Preview
require("typst-preview").setup({
    open_cmd = "open -g %s",
    invert_colors = "never",
    projectResolution = "lockDatabase",
    get_main_file = get_main_file,
})

-- 3. Helper to pin a specific path in Tinymist
local function pin_tinymist_file(path, notify)
    local clients = vim.lsp.get_clients({ name = "tinymist" })
    if #clients == 0 then
        return false
    end

    for _, client in ipairs(clients) do
        client:exec_cmd({
            title = "pinMain",
            command = "tinymist.pinMain",
            arguments = { path },
        }, { bufnr = 0 })
    end

    if notify then
        local name = path and vim.fn.fnamemodify(path, ":t") or "none"
        vim.notify("Pinned " .. name .. " as main Typst file", vim.log.levels.INFO)
    end
    return true
end

-- 4. User commands for manual overriding / unpinning
vim.api.nvim_create_user_command("TypstPinMain", function()
    local main_path = vim.fn.expand("%:p")
    pin_tinymist_file(main_path, true)
end, { desc = "Pin current file as Typst root/main document" })

vim.api.nvim_create_user_command("TypstUnpinMain", function()
    pin_tinymist_file(vim.NIL, false)
    vim.notify("Unpinned Typst main file", vim.log.levels.INFO)
end, { desc = "Unpin Typst root document" })

-- 5. FileType & LspAttach automations
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    callback = function(event)
        local map = function(keys, cmd, desc)
            vim.keymap.set("n", keys, cmd, { buffer = event.buf, silent = true, desc = "Typst: " .. desc })
        end

        -- Keymaps (aligned with your current bindings)
        map("<leader>ll", "<cmd>TypstPreviewToggle<cr>", "Preview Toggle")
        map("<localleader>lp", "<cmd>TypstPinMain<cr>", "Manually Pin Current as Main")
        map("<localleader>lk", "<cmd>TypstUnpinMain<cr>", "Unpin Main Root")
    end,
})

-- Automatically pin main file whenever Tinymist attaches
vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*.typ",
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.name == "tinymist" then
            local current_buf_path = vim.api.nvim_buf_get_name(event.buf)
            local main_file = get_main_file(current_buf_path)

            if main_file then
                pin_tinymist_file(main_file, false)
            end
        end
    end,
})
