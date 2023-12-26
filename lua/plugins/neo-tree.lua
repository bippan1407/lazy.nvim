return {
  "nvim-neo-tree/neo-tree.nvim",
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
}
