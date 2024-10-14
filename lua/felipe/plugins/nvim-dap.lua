return {
    "mfussenegger/nvim-dap",
    keys = function ()
        vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
        vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
        vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
        vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
        vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
        vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
        vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
        vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    end,
    config = function()
        local dap = require('dap')
        dap.configurations.java = {
            {
                type = 'java';
                request = 'attach';
                name = "Debug Attach(5005) - Remote";
                hostName = "127.0.0.1";
                port = 5005;
            },
            {
                type = 'java';
                request = 'attach';
                name = "Debug Attach (8080) - Remote";
                hostName = "127.0.0.1";
                port = 8080;
            },
        }
    end
}
