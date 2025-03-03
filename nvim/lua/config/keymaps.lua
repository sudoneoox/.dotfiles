local opts = { noremap = true, silent = true }
local keymap = vim.keymap
-- make jk behave like ESC
keymap.set("i", "jk", "<ESC>", opts)

-- the primeagen view remap
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- greatest key map ever buffer no replace when puts and delete
keymap.set("x", "<leader>p", '"_dP', opts)

-- delete duplicate neotree keymaps in default lazy
keymap.del("n", "<leader>e")
keymap.del("n", "<leader>E")

-- remove pgUp and pgDwn buttons
keymap.set({ "n", "v", "i" }, "<PageUp>", "<Nop>")
keymap.set({ "n", "v", "i" }, "<PageDown>", "<Nop>")
