local RA = {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
  ft = "rust",

  config = function ()
    vim.keymap.set("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
    vim.keymap.set("n", "<Leader>dr", "<cmd>lua vim.cmd('RustLsp runnables')<CR>", {desc = "Rust Runables"})
  end
}

local RV = {
  'rust-lang/rust.vim',
  ft = "rust",
  init = function()
    vim.g.rustfmt_autosave = 1
  end
}

local RC = {
  'saecki/crates.nvim',
  tag = 'stable',
  event = { "BufRead Cargo.toml" },
  config = function()
    require('crates').setup()
  end,
}

return {RA, RV, RC}
