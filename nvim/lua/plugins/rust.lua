
local RA = {
  'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function ()
      local mason_registry = require('mason-registry')

      if not mason_registry.has_package("codelldb") then
        mason_registry.refresh()
        if not mason_registry.has_package("codelldb") then
          vim.notify("codelldb is not installed. Install it with :MasonInstall codelldb", vim.log.levels.ERROR)
          return
        end
      end

      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path.. "lldb/lib/liblldb.dylib"
      local cfg = require('rustaceanvim.config')

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
}

local RV = {
  'rust-lang/rust.vim',
  ft = "rust",
  init = function()
    vim.g.rustfmt_autosave = 1
  end
}

return {RA, RV}

