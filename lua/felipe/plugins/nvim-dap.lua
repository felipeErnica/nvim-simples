return {
    "mfussenegger/nvim-dap",
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
