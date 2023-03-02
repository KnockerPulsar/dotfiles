local vim = vim

local custom_commands = {
	['Cfg'] = 'edit ~/.config/nvim/init.lua',
	['Plg'] = 'edit ~/.config/nvim/lua/plugins.lua',
	['Lsp'] = 'edit ~/.config/nvim/lua/lsp_init.lua',
	['Keys'] ='edit ~/.config/nvim/lua/keymaps.lua',
	['Packer'] ='edit ~/.config/nvim/lua/packer_init.lua',
}

for word, command in pairs(custom_commands) do
	vim.api.nvim_create_user_command(word, command,  {})
end

