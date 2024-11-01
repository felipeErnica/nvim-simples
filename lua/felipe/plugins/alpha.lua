return {
    'goolord/alpha-nvim', --Neovim greeter!
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
};
