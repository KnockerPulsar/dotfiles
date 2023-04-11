
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

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

vim.cmd [[
		autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
		autocmd! BufNewFile,BufRead *.cl set filetype=opencl 
]]

vim.cmd [[
		colorscheme gruber-darker
		set termguicolors
		set wildmenu 
		set wildmode=longest:list,full 
		set hidden 
]]

require('custom_commands')
require('keymaps')
require('plugins')

if vim.g.neovide then
		vim.g.neovide_scale_factor = 0.6
		vim.g.neovide_cursor_animation_length = 0.0
		vim.g.neovide_cursor_trail_size = 0.0
end

-- local onedark = require('onedark')
-- onedark.setup {
-- 	style = 'warmer'
-- }
-- onedark.load()

