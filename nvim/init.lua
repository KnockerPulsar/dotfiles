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

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions,terminal"
vim.o.undofile = true

vim.cmd [[
		colorscheme gruber-darker
		set termguicolors
		set hidden
]]

vim.cmd [[
		autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
		autocmd! BufNewFile,BufRead *.cl set filetype=opencl
]]

require('custom_commands')
require('keymaps')
require('plugins')

vim.cmd [[
		autocmd! VimLeavePre lua if(Minimal) { Set_minimal_ui(false) }
]]

