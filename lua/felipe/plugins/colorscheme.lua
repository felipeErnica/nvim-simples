return { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    lazy = false,
    priority = 1000,
    config = function() 
        require("catppuccin").setup({
            flavour = "mocha", 
            transparent_background = true, 
            show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
