-- has to be loaded before lazy
local global = vim.g
local buffer = vim.b
local map = vim.keymap

global.maplocalleader = " "
global.mapleader = " "

require("config.autocmds")
require("config.options")
require("config.lazy")
require("config.keymaps")

global.snacks_animate = false
buffer.snacks_animate = false
global.snacks_profiler = false

global.lazyvim_picker = "auto"

-- NOTE: git
map.del("n", "<leader>gg")
map.del("n", "<leader>gG")

-- NOTE: test
-- map.del("n", "<leader>t")
-- map.del("n", "<leader>tl")
-- map.del("n", "<leader>to")
-- map.del("n", "<leader>tO")
-- map.del("n", "<leader>tr")
-- map.del("n", "<leader>ts")
-- map.del("n", "<leader>tS")
-- map.del("n", "<leader>tt")
-- map.del("n", "<leader>tT")
-- map.del("n", "<leader>tw")

-- NOTE: file finder
map.del("n", "<leader><Space>")
