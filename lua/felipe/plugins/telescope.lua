return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'sharkdp/fd' },
    keys = function()
        local builtin = require('telescope.builtin')
        local keymap = vim.keymap
        keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope git files' })
        keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        keymap.set(
            'n',  
            '<leader>lg', 
            function() builtin.grep_string({ search = vim.fn.input("Grep > ")}) end,
            {}
        )
    end
}
