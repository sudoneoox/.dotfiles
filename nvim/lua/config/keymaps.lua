local opts = { noremap = true, silent = true }
local keymap = vim.keymap
local global = vim.g

global.mapleader = ' '
global.maplocalleader = ' '

-- make jk behave like ESC
keymap.set("i", "jk", "<ESC>", opts)


-- open up themery
-- keymap.set('n', '<leader>t', ':Themery<CR>', opts)
