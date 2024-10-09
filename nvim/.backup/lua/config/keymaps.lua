local opts = { noremap = true, silent = true }
local keymap = vim.keymap
local global = vim.g

global.maplocalleader = ' '
global.mapleader = ' '

-- make jk behave like ESC
keymap.set("i", "jk", "<ESC>", opts)

-- the primeagen view remap
keymap.set('v', "J", ":m '>+1<CR>gv=gv")
keymap.set('v', "K", ":m '<-2<CR>gv=gv")

-- greatest key map ever buffer no replace when puts and delete
keymap.set('x', '<leader>p', "\"_dP")
