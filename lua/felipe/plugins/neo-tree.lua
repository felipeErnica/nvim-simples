return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          source = "filesystem",
          position = "left",
        })
      end,
    },
  },
  config = function ()
    require("neo-tree").setup({
      filesystem = {
        follow_current_file = { enabled = true },
        components = {
          harpoon_index = function(config, node, _)
            local harpoon_list = require("harpoon"):list()
            local path = node:get_id()
            local harpoon_key = vim.uv.cwd()

            for i, item in ipairs(harpoon_list.items) do
              local value = item.value
              if string.sub(item.value, 1, 1) ~= "/" then
                value = harpoon_key .. "/" .. item.value
              end

              if value == path then
                vim.print(path)
                return {
                  text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
                  highlight = config.highlight or "NeoTreeDirectoryIcon",
                }
              end
            end
            return {}
          end,
        },
        renderers = {
          file = {
            { "icon" },
            { "name", use_git_status_colors = true },
            { "harpoon_index" }, --> This is what actually adds the component in where you want it
            { "diagnostics" },
            { "git_status", highlight = "NeoTreeDimText" },
          },
        },
      },
    })
  end
}
