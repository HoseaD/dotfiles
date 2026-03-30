return {
    "javiorfo/nvim-soil",
    lazy = true,
    ft = "plantuml",
    dependencies = {
        "javiorfo/nvim-nyctophilia",
    },
    config = function()
        require("soil").setup({
            image = {
                format = "png",
                viewer = "viu",
                execute_to_open = function(img)
                    return "true"
                end,
            },
        })

        -- Auto-run Soil on save
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*.puml", -- Only triggers for PlantUML files
            callback = function()
                -- Use pcall so that if PlantUML throws a warning,
                -- it doesn't interrupt your typing or show a big error window.
                -- pcall(vim.cmd, "Soil")
                vim.cmd("silent! Soil")
                vim.cmd("redraw")
            end,
        })
    end,
}
