local vim = vim

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

function Filter_symbols(_args)
	local args = _args.fargs
	local filter_fn = function(items) return items end

	if #args ~= 0 then
		local symbol = args[1]

		-- Make sure the given argument is a valid symbol
		local found = false
		for i = 1, #vim.lsp.protocol.SymbolKind do
			if symbol == vim.lsp.protocol.SymbolKind[i] then
				found = true
			end
		end

		if not found then
			vim.api.nvim_err_writeln("Argument must be one of: " ..
				table.concat(vim.lsp.protocol.SymbolKind, ', '))
		end

		filter_fn = function(items)
			local filtered_symbols = {}
			for i = 1, #items do
				if items[i].kind == symbol then
					table.insert(filtered_symbols, items[i])
				end
			end
			return filtered_symbols
		end
	end

	vim.lsp.buf.document_symbol({
		on_list = function(options)
			vim.fn.setloclist(vim.fn.winnr(), filter_fn(options.items), 'r')
			vim.api.nvim_command('lopen')
			vim.api.nvim_command('lfirst')
		end

	})
end

local custom_commands = {
	{ cmd_name = 'Cfg',           cmd = 'edit ~/.configd/nvim/init.lua',               options = {} },
	{ cmd_name = 'Cmd',           cmd = 'edit ~/.config/nvim/lua/custom_commands.lua', options = {} },
	{ cmd_name = 'Plg',           cmd = 'edit ~/.config/nvim/lua/plugins.lua',         options = {} },
	{ cmd_name = 'Lsp',           cmd = 'edit ~/.config/nvim/lua/lsp_init.lua',        options = {} },
	{ cmd_name = 'Keys',          cmd = 'edit ~/.config/nvim/lua/keymaps.lua',         options = {} },
	{ cmd_name = 'Packer',        cmd = 'edit ~/.config/nvim/lua/packer_init.lua',     options = {} },
	{ cmd_name = 'NextError',     cmd = 'lua vim.diagnostic.goto_next()',              options = {} },
	{ cmd_name = 'PrevError',     cmd = 'lua vim.diagnostic.goto_prev()',              options = {} },
	{ cmd_name = 'FilterSymbols', cmd = Filter_symbols,                                options = { nargs = '?' } },
	{ cmd_name = 'Fmt',           cmd = function() vim.lsp.buf.format() end,           options = {} },
}

for _, cc in ipairs(custom_commands) do
	vim.api.nvim_create_user_command(cc.cmd_name, cc.cmd, cc.options)
end
