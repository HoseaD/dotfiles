-- Configure neotest
require("neotest").setup({
    adapters = {
        require("rustaceanvim.neotest")({}),
    },
    -- Override the default UI icons
    icons = {
        passed = "✓",
        failed = "✗",
        skipped = "⊘", -- Clear visual indicator for skipped files
        unknown = "?", -- Clear indicator for unknown states

        -- Change the spinner frames so it doesn't use the standard dash "-"
        running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    },
})

require("coverage").setup({
    lang = {
        -- rust = {
        --     -- Point strictly to the workspace root's target folder
        --     coverage_file = "/target/lcov.info",
        -- },
    },
})

local map = vim.keymap.set

-- === Neotest: For fast Pass/Fail feedback ===

-- Run the single test your cursor is currently inside
map("n", "<leader>tr", function()
    require("neotest").run.run()
end, { desc = "Run Nearest Test" })

-- Run all tests in the current file
map("n", "<leader>tf", function()
    require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run File Tests" })

-- Run all tests in the workspace
map("n", "<leader>tw", function()
    require("neotest").run.run(vim.fn.getcwd())
end, { desc = "Run Workspace Tests" })

-- Open the neotest summary panel
map("n", "<leader>ts", function()
    require("neotest").summary.toggle()
end, { desc = "Toggle Test Summary" })

-- === Nvim-Coverage: For coverage metrics ===

map("n", "<leader>tc", function()
    vim.cmd("CoverageLoadLcov target/lcov.info")
    vim.cmd("CoverageShow")
end, { desc = "Load Workspace Coverage" })
map("n", "<leader>tt", ":CoverageToggle<CR>", { desc = "Show Coverage" })
map("n", "<leader>tp", ":CoverageSummary<CR>", { desc = "Show Coverage Percentages" })
map("n", "<leader>tx", ":CoverageClear<CR>", { desc = "Clear Coverage Markers" })
