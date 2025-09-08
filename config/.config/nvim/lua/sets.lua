vim.cmd("set spelllang=en_us")
vim.cmd("set spell")

vim.cmd("set termguicolors")

vim.cmd("set scrolloff=25")
vim.cmd("set number")
vim.cmd("set relativenumber")

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.cmd("set expandtab")
vim.cmd("set smartindent")

-- Improve searching
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set incsearch")
vim.cmd("set nohlsearch")

vim.cmd("set backspace=indent,eol,start")

-- Sets line break column to ensure consistency.
vim.cmd("set colorcolumn=80")
vim.cmd("set  signcolumn=yes")

-- Split below and right
vim.cmd("set splitbelow")
vim.cmd("set splitright")

vim.cmd('au BufNewFile,BufRead *.ejs set filetype=html')

