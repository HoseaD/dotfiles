local opt = vim.opt

opt.shell = "/bin/zsh"

-- Better diffs everywhere (gitsigns, diffview, :diffthis)
opt.diffopt:append({ "internal", "filler", "closeoff", "algorithm:histogram", "linematch:60" })

-- Draw rounded borders on all floating windows (LSP hover, diagnostics, etc.)
vim.o.winborder = "rounded"

-- enable line number and relative line number
opt.number = true
opt.relativenumber = true

-- enable mouse support in all modes
opt.mouse = "a"

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces per tab character
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true -- enable line wrapping
opt.showbreak = "+++"
opt.colorcolumn = "100"

opt.cmdheight = 0

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- clipboard
opt.clipboard = "unnamedplus" -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- minimal number of scree lines to keep above and below the cursor.
opt.scrolloff = 10

-- turn off swapfile
opt.swapfile = false

-- Save undo history
opt.undofile = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Folding (treesitter-based; see lua/plugins/treesitter.lua)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99 -- Using a high number ensures all folds are open
opt.foldlevelstart = 99 -- Start with all folds open when opening a new buffer
opt.foldenable = true -- Keep folding enabled

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
