return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,
            show_end_of_buffer = false,
            integrations = {
                harpoon = true,
            },
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
