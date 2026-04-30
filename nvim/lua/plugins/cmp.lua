-- lua/plugins/cmp.lua

require("blink.cmp").setup({
    -- 'default' (Ctrl+y to accept)
    -- 'enter' (Enter to accept)
    -- 'super-tab' (Tab to accept and cycle snippets, highly recommended)
    keymap = { preset = "super-tab" },

    appearance = {
        -- Sets fallback highlight groups to nvim-cmp's highlight groups
        use_nvim_cmp_as_default = true,
        -- Adjusts spacing to ensure icons are aligned. Can be 'mono' or 'normal'
        nerd_font_variant = "mono",
    },

    sources = {
        -- These are the default sources. Blink handles prioritizing them automatically!
        default = { "lsp", "path", "snippets", "buffer" },
    },

    -- Experimental but highly recommended features
    signature = { enabled = true },
    completion = {
        accept = { auto_brackets = { enabled = true } },
    },
})
