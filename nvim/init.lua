
vim.wo.rnu = true
vim.wo.nu = true
vim.bo.autoindent = true
vim.o.undofile = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamedplus"
vim.opt.timeoutlen = 500
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.wrap = false
vim.opt.undodir = vim.fn.stdpath('config') .. '/undo'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.mouse = ""


vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
vim.cmd [[autocmd! BufNewFile,BufRead *.cl set filetype=opencl ]]

vim.cmd [[set termguicolors]]
vim.cmd [[colorscheme ayu]]

require('custom_commands')
require('keymaps')
require('plugins')

-- local onedark = require('onedark')
-- onedark.setup {
-- 	style = 'warmer'
-- }
-- onedark.load()

