require("config.options")
require("config.keymaps")
require("config.autcmds")

vim.pack.add({
    -- Neotree
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3") },
    -- dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    -- optional, but recommended
    "https://github.com/nvim-tree/nvim-web-devicons",

    -- Colorscheme
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    -- Minimal UI Components
    "https://github.com/echasnovski/mini.statusline",
    "https://github.com/echasnovski/mini.indentscope",
    "https://github.com/stevearc/dressing.nvim",

    -- Notifications and UI Overrides
    "https://github.com/rcarriga/nvim-notify",

    -- Git & VCS
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/sindrets/diffview.nvim", -- Highly recommended for Neogit
    "https://github.com/NeogitOrg/neogit",
    "https://github.com/kdheepak/lazygit.nvim",
    -- Jujutsu
    { src = "https://github.com/nicolasgb/jj.nvim", branch = "main" },
    "https://github.com/rafikdraoui/jj-diffconflicts",

    -- Flash - sneak through the code
    "https://github.com/folke/flash.nvim",

    -- Add mini.pick and mini.extra (for LSP pickers)
    "https://github.com/echasnovski/mini.pick",
    "https://github.com/echasnovski/mini.extra",
    "https://github.com/echasnovski/mini.icons",
    "https://github.com/echasnovski/mini.pairs",

    -- Add which-key
    "https://github.com/folke/which-key.nvim",

    -- LSP and formatting (Note the full URLs!)
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

    "https://github.com/j-hui/fidget.nvim",

    -- Formatting engine
    "https://github.com/stevearc/conform.nvim",

    -- Treesitter and its text-objects extension
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", name = "nvim-treesitter-textobjects" },

    -- Blink completion engine
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1") },
    -- Snippet collection (Optional, but highly recommended)
    "https://github.com/rafamadriz/friendly-snippets",

    -- Rust
    { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") },
    "https://github.com/saecki/crates.nvim",

    -- Testing tools
    "https://github.com/antoinemadec/FixCursorHold.nvim", -- Recommended by neotest
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/nvim-neotest/neotest", -- The test runner
    "https://github.com/andythigpen/nvim-coverage", -- The coverage visualizer

    -- Latex
    "https://github.com/lervag/vimtex",
    -- Typst
    "https://github.com/chomosuke/typst-preview.nvim",

    -- -- PlantUML / Soil
    -- "https://github.com/javiorfo/nvim-nyctophilia",
    -- "https://github.com/javiorfo/nvim-soil",

    -- Markdown
    -- { src = "https://github.com/OXY2DEV/markview.nvim" },
})

require("plugins.colorscheme")
require("plugins.neo-tree")
require("plugins.lsp")
require("plugins.formatter")
require("plugins.picker")
require("plugins.git_stuff")
require("plugins.vimtex")
require("plugins.typst")
require("plugins.whichkey")
require("plugins.cmp")
-- require("plugins.markview")

require("plugins.treesitter")

require("plugins.test")

require("plugins.rust")

require("plugins.flash")
require("plugins.ui")

require("plugins.soil")
