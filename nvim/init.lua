-- has to be loaded before lazy
local global = vim.g
global.maplocalleader = ' '
global.mapleader = ' '

require("config.autocmds")
require("config.options")
require("config.lazy")
require("config.keymaps")
