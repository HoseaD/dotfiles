vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "term://*#toggleterm#*",
    callback = function()
        if vim.bo.filetype == 'toggleterm' then
            vim.cmd('startinsert')
            vim.wo.spell = false
        end
    end,
    desc = "Automatically switch to insert mode when entering a toggleterm window",
})

