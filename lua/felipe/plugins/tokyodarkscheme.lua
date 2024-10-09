return {
    "tiagovla/tokyodark.nvim",
    lazy = false,
    config = function(_, opts)
        require("tokyodark").setup(opts) 
        vim.cmd [[colorscheme tokyodark]]
    end
}
