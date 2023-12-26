return {
  "akinsho/toggleterm.nvim",
  keys = {
    {
      "<leader>gg",
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({
          cmd = "lazygit",
          hidden = true,
          direction = "float",
          float_opts = {
            border = "single",
            width = function()
              return math.floor(vim.o.columns * 1)
            end,
            height = function()
              return math.floor(vim.o.lines * 1)
            end,
            winblend = 3,
          },
        })
        lazygit:toggle()
      end,
    },
  },
}
