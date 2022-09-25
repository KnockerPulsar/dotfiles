
vim.opt.wrap = false
vim.wo.rnu = true
vim.wo.nu = true
vim.bo.autoindent = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamedplus"

require('plugins')
vim.cmd [[colorscheme moonfly]]
