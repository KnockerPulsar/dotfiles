vim.bo.autoindent = true

vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamedplus"
vim.opt.timeoutlen = 500
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.undodir = vim.fn.stdpath('config') .. '/undo'
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions,terminal"
vim.o.undofile = true

vim.o.wildmode = "longest,list"

vim.cmd [[
		colorscheme gruber-darker
		set termguicolors
		set hidden
]]

vim.cmd [[
		autocmd! BufNewFile,BufRead *.cl set filetype=opencl
]]

require('custom_commands')
require('keymaps')
require('plugins')
