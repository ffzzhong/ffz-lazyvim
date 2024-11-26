-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", "<Nop>")
vim.keymap.set("n", "<right>", "<Nop>")
vim.keymap.set("n", "<up>", "<Nop>")
vim.keymap.set("n", "<down>", "<Nop>")

-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "move focus to the right window" })
-- as <C-j> and <C-k> is mapped to <down> and <up> at system level
vim.keymap.set("n", "<down>", "<C-w><C-j>", { desc = "move focus to the lower window" })
vim.keymap.set("n", "<up>", "<C-w><C-k>", { desc = "move focus to the upper window" })

-- resize window
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- yank
vim.keymap.set("v", "y", "y`]", { desc = "yank without the cursor moving to the top of the block" })
vim.keymap.set("n", "Y", "y$", { desc = "yank whole line" })

-- paste
vim.keymap.set("n", "<C-p>", 'viw"0p', { desc = "replace words with yanked text, multiple times" })

-- inline move
vim.keymap.set({ "n", "v" }, "H", "^")
vim.keymap.set({ "n", "v" }, "L", "$")

-- command mode
vim.keymap.set("n", ";", ":")

-- search
vim.keymap.set("n", "<space>", "/")

-- append new line without going to insert mode
vim.keymap.set("n", "al", "o<esc>")

-- select all
vim.keymap.set("n", "<leader>sa", "ggVG", { desc = "select all" })

-- save & quit
-- vim.keymap.del("n", "<leader>q")
-- vim.keymap.del("n", "<leader>w")
vim.keymap.del("n", "<leader>qq")
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "quickly quit the currentch window" })
vim.keymap.del("n", "<leader>wm") -- remove the keymap to zoom window
vim.keymap.del("n", "<leader>wd") -- remove the keymap to delete window
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "quickly save the current buffer" })

-- undo
vim.keymap.set("n", "U", "<C-r>")

-- buffers
vim.keymap.set("n", "<left>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<right>", "<cmd>bnext<cr>")
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>")
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")

-- commenting
vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>normal gcc<cr>", { desc = "comment" })
vim.keymap.set({ "n", "v" }, "<leader>cu", "<cmd>normal gcc<cr>", { desc = "uncomment" })

-- accelerated j, k movement
vim.keymap.del({ "n", "x" }, "j")
vim.keymap.del({ "n", "x" }, "k")
vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})

-- TODO:  <31-10-24, lingfeng> --
-- create a keymap to zoom the current window
-- can refer: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-misc.md

-- TODO:  <31-10-24, lingfeng> --
-- create keymaps for mark operations
