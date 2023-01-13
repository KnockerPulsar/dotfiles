local vim = vim
vim.api.nvim_create_user_command('Cfg', 'edit ~/.config/nvim/init.lua', {})
vim.api.nvim_create_user_command('Plg', 'edit ~/.config/nvim/lua/plugins.lua', {})
vim.api.nvim_create_user_command('Lsp', 'edit ~/.config/nvim/lua/lsp_init.lua', {})
