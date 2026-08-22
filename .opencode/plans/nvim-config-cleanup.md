# Neovim config cleanup & fixes

Context: mid-migration lazy.nvim -> native `vim.pack` (Neovim 0.13-dev). Scan found dead
migration debris, a few real bugs, and modernization opportunities. User decisions:
enable mini.pairs, drop PlantUML/soil, delete all stale lazy-spec files, clean stale data.

## Phase 1 — Bug fixes (in-repo edits)

1. `init.lua`
   - Remove commented-out soil/nyctophilia + markview lines from the add-list.
   - Remove `-- require("plugins.markview")` and `require("plugins.soil")`.
2. Delete `lua/plugins/soil.lua` (plugin no longer installed; module errors on .puml).
3. `lua/plugins/ui.lua` — enable autopairs: `require("mini.pairs").setup()` as section 3;
   renumber dressing to 4.
4. `lua/plugins/treesitter.lua` + `lua/config/options.lua`
   - FileType autocmd: early-return when `vim.b[event.buf].is_large_file`; only set
     `indentexpr` after `pcall(vim.treesitter.start, ...)` succeeds; stop mutating
     window-local fold options per-FileType.
   - Move folding to globals in options.lua: `foldmethod = "expr"`,
     `foldexpr = "v:lua.vim.treesitter.foldexpr()"`.
5. New `lua/config/capabilities.lua` — shared blink.cmp capabilities builder
   (make_client_capabilities + positionEncodings + blink.get_lsp_capabilities with pcall).
   Use it from `lsp.lua` and `rust.lua` (removes copy-paste).
6. `lua/plugins/rust.lua` — remove BufWritePre `vim.lsp.buf.format` (double-format:
   conform's `format_on_save` with `lsp_format = "fallback"` already formats rust via
   rust-analyzer).
7. `lua/plugins/picker.lua` — link `MiniPickPrompt` to `FloatTitle` instead of
   nonexistent `TelescopePromptTitle`; drop Noice reference comment.
8. `lua/config/autcmds.lua` — remove dead toggleterm autocmd (plugin not installed).
9. `lua/plugins/test.lua` — replace `<leader>tc` mapping (chained commands with stray
   `|`) with a Lua callback calling `CoverageLoadLcov target/lcov.info` then
   `CoverageShow`.
10. `lua/plugins/whichkey.lua` — remove empty `<leader>c` group.

## Phase 2 — Modernization

11. `lua/config/options.lua`
    - Add `vim.o.winborder = "rounded"` (native, borders all floats incl. diagnostics).
    - Fix comment lies: "disable mouse" -> enable (`mouse = "a"`); tabstop comment says
      2 spaces but sets 4.
12. `lua/plugins/lsp.lua` — delete `open_floating_preview` monkey-patch and redundant
    float border overrides now covered by winborder; keep fidget setup, keymaps,
    server configs, mason boot.

## Phase 3 — Dead code removal

13. Delete stale files never required by init.lua:
    `noice.lua, markdown.lua, telescope.lua, term.lua, mcphub.lua, debug.lua,
    comment.lua, csv.lua, vim-sleuth.lua, undotree.lua, neotest.lua, ai.lua,
    markview.lua, mini.lua, treesitter-textobjects.lua`
14. Delete legacy entrypoint remnants: `lua/config/lazy.lua`, `lazy-lock.json`.

## Phase 4 — Data cleanup (outside repo)

15. `rm -rf ~/.local/share/nvim/lazy` (~321 MB orphaned lazy.nvim plugins).
16. Orphaned vim.pack repos not in init.lua add-list: compute exact diff at execution
    time, then remove via headless `vim.pack.del(...)` or rm. Expected orphans:
    fzf-lua, gitlinker.nvim, markview.nvim, mini.files, mini.surround, neoscroll.nvim,
    neotest-rust, noice.nvim, nvim-treesitter-context, nvim-ufo, render-markdown.nvim,
    vim-fugitive.

## Verification

- `nvim --headless "+lua print('startup-ok')" +qa` — catches load-time errors.
- Open a real file: TS highlight/fold still works, no diagnostic spam.
- Run stylua over edited lua files if available.
- Note for later (not in scope): `nvim-notify` is installed but nothing sets
  `vim.notify` anymore once noice.lua is gone — wire it in ui.lua or drop it.
