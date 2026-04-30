-- return {
--     "javiorfo/nvim-soil",
--     lazy = true,
--     ft = "plantuml",
--     dependencies = {
--         "javiorfo/nvim-nyctophilia",
--     },
--     config = function()
--         require("soil").setup({
--             image = {
--                 format = "png",
--                 viewer = "viu",
--                 execute_to_open = function(img)
--                     return "true"
--                 end,
--             },
--         })
--
--         -- Auto-run Soil on save
--         vim.api.nvim_create_autocmd("BufWritePost", {
--             pattern = "*.puml", -- Only triggers for PlantUML files
--             callback = function()
--                 -- Use pcall so that if PlantUML throws a warning,
--                 -- it doesn't interrupt your typing or show a big error window.
--                 pcall(vim.cmd, "Soil")
--                 vim.cmd("silent! Soil")
--                 vim.cmd("redraw")
--             end,
--         })
--     end,
-- }

-- lua/plugins/soil.lua

-- lua/plugins/soil.lua

local soil_group = vim.api.nvim_create_augroup("PlantUMLSetup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = soil_group,
    pattern = "plantuml",
    callback = function(event)
        -- 1. Setup Soil (Silent Mode)
        require("soil").setup({
            image = {
                format = "png",
                -- We override the execution command to a harmless shell command ("true").
                -- This forces Soil to generate the PNG but prevents it from opening a window.
                execute_to_open = function(img)
                    return "true"
                end,
            },
        })

        -- 2. Auto-compile on save
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = soil_group,
            buffer = event.buf,
            callback = function()
                vim.cmd("silent! Soil")
                vim.cmd("redraw")
            end,
        })
    end,
})
