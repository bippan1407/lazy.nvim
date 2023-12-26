-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local set = vim.keymap.set
local delete = vim.api.nvim_del_keymap
local opts = { noremap = true, silent = true }

vim.opt.winbar = "%=%m %f"

set("i", "jk", "<Esc>", opts)
set("n", "<leader>rn", ":IncRename ")

delete("n", "<leader>`")
delete("n", "<leader>|")
delete("n", "<leader>-")
delete("n", "<leader>fT")

set("n", "<C-S-Up>", "<cmd>resize +2<cr>", opts)
set("n", "<C-S-Down>", "<cmd>resize -2<cr>", opts)
set("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", opts)
set("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", opts)
