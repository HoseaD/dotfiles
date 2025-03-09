local mini = {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        -- Enable modules you want
        require('mini.pairs').setup()
    end
}

return mini
