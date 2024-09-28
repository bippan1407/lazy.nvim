return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree",
    },
    {
      "<leader>fE",
      false,
    },
    {
      "<leader>E",
      false,
    },
    {
      "<leader>fe",
      false,
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      follow_current_file = { enabled = true },
    },
  },
}
