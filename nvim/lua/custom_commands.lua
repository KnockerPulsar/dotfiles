local vim = vim

Minimal = false

-- Opens the header file on the left and the cpp file on the right.
-- Can only be called from a .h/.hpp and .c/.cpp files
function Open_corresponding_file()
	local extension = vim.fn.expand('%:e')
	local base = vim.fn.expand('%:t:r')
	local directory = vim.fn.expand('%:p:h')

	local extension_valid =
	    extension == 'h' or extension == 'hpp'
	    or extension == 'c' or extension == 'cpp' or extension == "cxx"

	if not extension_valid then
		print('Not a valid C++ header or source file.')
		return
	end

	local header = directory .. '/' .. base .. '.h'
	local cpp = directory .. '/' .. base .. '.cpp'
	local original_window = vim.fn.win_getid()

	-- Toggle the current buffer to take all the window's space
	vim.cmd('only')

	-- Open header on the left side
	vim.cmd('vert split ' .. header)

	-- Open cpp on the right side
	vim.cmd('vert split ' .. cpp)

	vim.api.nvim_win_close(original_window, true)
end

function Open_corresponding_source_file()
	local extension = vim.fn.expand('%:e')
	local base = vim.fn.expand('%:t:r')
	local directory = vim.fn.expand('%:p:h')

	local extension_valid = extension == 'h' or extension == 'hpp'

	if not extension_valid then
		print('Not a valid C++ header file.')
		return
	end

	local cpp = directory .. '/' .. base .. '.cpp'

	vim.cmd('edit ' .. cpp)
end

function Open_corresponding_header_file()
	local extension = vim.fn.expand('%:e')
	local base = vim.fn.expand('%:t:r')
	local directory = vim.fn.expand('%:p:h')

	local extension_valid = extension == 'c' or extension == 'cpp' or extension == 'cc'

	if not extension_valid then
		print('Not a valid C++ source file.')
		return
	end

	local header = directory .. '/' .. base .. '.h'

	vim.cmd('edit ' .. header)
end

function Set_minimal_ui(minimal)
	if minimal then
		vim.opt.laststatus = 1
		vim.opt.cmdheight = 1

		vim.cmd('windo set nornu nonu signcolumn=no')
	else
		vim.opt.laststatus = 0
		vim.opt.cmdheight = 0

		vim.cmd('windo set rnu nu signcolumn=auto')
	end

	require('ibl').update({ enabled = Minimal })
end

function Toggle_minimal_ui()
	Set_minimal_ui(Minimal)
	Minimal = not Minimal
end

local custom_commands = {
	['Cfg'] = 'edit ~/.config/nvim/init.lua',
	['Cmd'] = 'edit ~/.config/nvim/lua/custom_commands.lua',
	['Plg'] = 'edit ~/.config/nvim/lua/plugins.lua',
	['Lsp'] = 'edit ~/.config/nvim/lua/lsp_init.lua',
	['Keys'] = 'edit ~/.config/nvim/lua/keymaps.lua',
	['Packer'] = 'edit ~/.config/nvim/lua/packer_init.lua',
	['NextError'] = 'lua vim.diagnostic.goto_next()',
	['PrevError'] = 'lua vim.diagnostic.goto_prev()',
	['Twin'] = 'lua Open_corresponding_file()',
	['Src'] = 'lua Open_corresponding_source_file()',
	['Hdr'] = 'lua Open_corresponding_header_file()',
	['MinimalUI'] = 'lua Toggle_minimal_ui()',
	['Fmt'] = 'lua vim.lsp.buf.format()'
}

for word, command in pairs(custom_commands) do
	vim.api.nvim_create_user_command(word, command, {})
end
