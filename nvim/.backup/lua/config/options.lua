local opt = vim.opt
local g = vim.g

-- line numbers
opt.relativenumber = true
opt.number = true
opt.ruler = true


-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line indenting
opt.wrap = false

-- cursor line
opt.cursorline = true

-- search settings
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspaces
opt.backspace = "indent,eol,start"

-- split window
opt.splitright = true
opt.splitbelow = true
opt.iskeyword:append("-")

-- clipboard
opt.clipboard = "unnamedplus"

-- command line
opt.wildmenu = true
opt.showcmd = true


-- colors
opt.termguicolors = true
