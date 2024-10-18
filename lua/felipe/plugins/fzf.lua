
return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = function ()
        vim.keymap.set("n", "<leader>ca" ,function () require('fzf-lua').lsp_code_actions() end, {silent = true})
    end,
}
