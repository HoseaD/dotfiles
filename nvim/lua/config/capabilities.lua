-- Shared LSP capabilities used by all servers (lsp.lua, rust.lua)
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- FORCE all servers to agree on UTF-8 as the primary position encoding
capabilities.general = capabilities.general or {}
capabilities.general.positionEncodings = { "utf-8", "utf-16" }

local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
end

return capabilities
