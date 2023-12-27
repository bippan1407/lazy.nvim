local function is_git_dir()
  local folder_path = vim.fn.getcwd()
  local git_dir = folder_path .. "/.git"
  local file = io.open(git_dir, "r")
  if file then
    io.close(file)
    return true
  end
  return false
end

FloatTerminals = {}
function GetFirstFloatTerminalId()
  local firtstFloatTermId
  for _, value in pairs(FloatTerminals) do
    firtstFloatTermId = value
    break
  end
  return firtstFloatTermId
end
function tableToString(tbl)
  local result = "{ "

  for key, value in pairs(tbl) do
    result = result .. '"' .. tostring(key) .. '": "' .. tostring(value) .. '", '
  end

  -- Remove the trailing comma and space
  result = result:sub(1, -3)

  result = result .. " }"

  return result
end

return {
  "akinsho/toggleterm.nvim",
  dependencies = {
    "rcarriga/nvim-notify",
  },
  keys = {
    { "<leader>gG", false },
    {
      "<leader>tf",
      function()
        local toggleTerm = require("toggleterm")
        local Terminal = require("toggleterm.terminal").Terminal
        local notify = require("notify")
        local floatTerminalId = GetFirstFloatTerminalId()
        if floatTerminalId == nil then
          local terminal = Terminal:new({
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
          FloatTerminals[1] = terminal.id
          -- notify("add " .. tableToString(terminal))
          terminal:toggle()
        else
          notify("get " .. floatTerminalId)
          if not (floatTerminalId == nil) then
            toggleTerm.toggle(floatTerminalId)
          end
        end
      end,
      desc = "float terminal",
    },
    -- {
    --   "<leader>th",
    --   function()
    --     local Terminal = require("toggleterm.terminal").Terminal
    --     local terminal = Terminal:new({
    --       hidden = true,
    --       direction = "horizontal",
    --       float_opts = {
    --         border = "single",
    --         width = function()
    --           return math.floor(vim.o.columns * 1)
    --         end,
    --         height = function()
    --           return math.floor(vim.o.lines * 0.3)
    --         end,
    --         winblend = 3,
    --       },
    --     })
    --     local opts = { buffer = 0 }
    --     vim.keymap.set("t", "<esc>", function()
    --       terminal:toggle()
    --     end, opts)
    --     terminal:toggle()
    --   end,
    --   desc = "horizontal terminal",
    -- },
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
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", "<C-/>", opts)
        lazygit:toggle()
      end,
      desc = "Lazygit",
    },
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
      desc = "Lazygit",
    },
    {
      "<leader>gc",
      "<cmd>Telescope git_branches<cr>",
      desc = "Git branches",
    },
    {
      "<leader>gb",
      function()
        local notify = require("notify")
        if is_git_dir() then
          local result = vim.fn.system("git branch --show-current")
          notify("Branch name - " .. result)
        end
      end,
      desc = "Git current branch name",
    },
    {
      "<leader>gp",
      function()
        local notify = require("notify")
        if is_git_dir() then
          local result = vim.fn.system("git pull")
          notify("Git pull.\n" .. result)
        end
      end,
      desc = "Git pull changes",
    },
    {
      "<leader>gs",
      function()
        local notify = require("notify")
        if is_git_dir() then
          local result = vim.fn.system("git stash save")
          notify("Stash saved.\n" .. result)
        end
      end,
      desc = "Git stash changes",
    },
    {
      "<leader>ga",
      function()
        local notify = require("notify")
        if is_git_dir() then
          local result = vim.fn.system("git stash apply")
          notify("Stash applied.\n" .. result)
        end
      end,
      desc = "Git apply latest stash",
    },
  },
}
