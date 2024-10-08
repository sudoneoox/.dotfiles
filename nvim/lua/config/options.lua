local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line indenting
opt.wrap = false

-- cureson line
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
