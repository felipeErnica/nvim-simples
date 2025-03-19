return {
    "ThePrimeagen/harpoon",
    name = "harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        local list = harpoon:list()

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() list:add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(list) end)

        vim.keymap.set("n", "<C-h>", function() list:select(1) end)
        vim.keymap.set("n", "<C-j>", function() list:select(2) end)
        vim.keymap.set("n", "<C-k>", function() list:select(3) end)
        vim.keymap.set("n", "<C-l>", function() list:select(4) end)

        vim.keymap.set("n", "<leader><C-h>", function() list:replace_at(1) end)
        vim.keymap.set("n", "<leader><C-j>", function() list:replace_at(2) end)
        vim.keymap.set("n", "<leader><C-k>", function() list:replace_at(3) end)
        vim.keymap.set("n", "<leader><C-l>", function() list:replace_at(4) end)
    end
}
