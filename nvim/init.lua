
vim.wo.rnu = true
vim.wo.nu = true
vim.bo.autoindent = true
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


-- Seems like moonfly needs treesitter to run manually or something for the hightlighting
-- to work properly?
-- Setting the colorscheme to carbonfox does this.
-- vim.cmd [[colorscheme carbonfox]]
-- vim.cmd [[colorscheme moonfly]]
vim.cmd [[colorscheme ayu]]
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

require('plugins')

-- local onedark = require('onedark')
-- onedark.setup {
-- 	style = 'warmer'
-- }
-- onedark.load()

