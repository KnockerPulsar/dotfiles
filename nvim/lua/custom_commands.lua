local vim = vim

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
			return
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
			local filtered_items = filter_fn(options.items)
			vim.fn.setloclist(vim.fn.winnr(), filtered_items, 'r')
			if #filtered_items > 0 then
				vim.api.nvim_command('lopen')
				vim.api.nvim_command('lfirst')
			else
				print("No results found")
			end
		end
	})
end

function Copy_current_file_path()
	local filepath = vim.fn.expand('%')
	local line_number, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local full_path = filepath .. ":" .. line_number
	vim.fn.setreg('+', full_path) -- write to clippoard
end

-- https://github.com/rmarganti/.dotfiles/blob/85e8baaf04f52085da58fb3d17941a0cc0ac0d5e/dots/.config/nvim/lua/rmarganti/core/autocommands.lua#L12
local function delete_qf_items()
    local mode = vim.api.nvim_get_mode()['mode']

    local start_idx
    local count

    if mode == 'n' then
        -- Normal mode
        start_idx = vim.fn.line('.')
        count = vim.v.count > 0 and vim.v.count or 1
    else
        -- Visual mode
        local v_start_idx = vim.fn.line('v')
        local v_end_idx = vim.fn.line('.')

        start_idx = math.min(v_start_idx, v_end_idx)
        count = math.abs(v_end_idx - v_start_idx) + 1

        -- Go back to normal
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes(
                '<esc>', -- what to escape
                true, -- Vim leftovers
                false, -- Also replace `<lt>`?
                true -- Replace keycodes (like `<esc>`)?
            ),
            'x', -- Mode flag
            false -- Should be false, since we already `nvim_replace_termcodes()`
        )
    end

    local qflist = vim.fn.getqflist()

    for _ = 1, count, 1 do
        table.remove(qflist, start_idx)
    end

    vim.fn.setqflist(qflist, 'r')
    vim.fn.cursor(start_idx, 1)
end

local custom_group = vim.api.nvim_create_augroup('custom', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    group = custom_group,
    pattern = 'qf',
    callback = function()
        -- Do not show quickfix in buffer lists.
        vim.api.nvim_buf_set_option(0, 'buflisted', false)

        -- Escape closes quickfix window.
        vim.keymap.set(
            'n',
            '<ESC>',
            '<CMD>cclose<CR>',
            { buffer = true, remap = false, silent = true }
        )

        -- `dd` deletes an item from the list.
        vim.keymap.set('n', 'dd', delete_qf_items, { buffer = true })
        vim.keymap.set('x', 'd', delete_qf_items, { buffer = true })
    end,
    desc = 'Quickfix tweaks',
})

local custom_commands = {
	{ cmd_name = 'Cfg',           cmd = 'edit ~/.config/nvim/init.lua',                options = {} },
	{ cmd_name = 'Cmd',           cmd = 'edit ~/.config/nvim/lua/custom_commands.lua', options = {} },
	{ cmd_name = 'Plg',           cmd = 'edit ~/.config/nvim/lua/plugins.lua',         options = {} },
	{ cmd_name = 'Lsp',           cmd = 'edit ~/.config/nvim/lua/lsp_init.lua',        options = {} },
	{ cmd_name = 'Keys',          cmd = 'edit ~/.config/nvim/lua/keymaps.lua',         options = {} },
	{ cmd_name = 'Packer',        cmd = 'edit ~/.config/nvim/lua/packer_init.lua',     options = {} },
	{ cmd_name = 'FilterSymbols', cmd = Filter_symbols,                                options = { nargs = '?' } },
	{ cmd_name = 'Fmt',           cmd = function() vim.lsp.buf.format() end,           options = {} },
	{ cmd_name = 'CopyPath',      cmd = Copy_current_file_path,           	           options = {} },
}

for _, cc in ipairs(custom_commands) do
	vim.api.nvim_create_user_command(cc.cmd_name, cc.cmd, cc.options)
end

local function get_git_info()
  local file_path = vim.fn.expand('%:p')
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.expand('%:p:h') .. ' rev-parse --show-toplevel')[1]

  if vim.v.shell_error ~= 0 then
    print("Not a git repository")
    return nil
  end

  local relative_path = file_path:sub(#git_root + 2)
  local commit_hash = vim.fn.systemlist('git -C ' .. git_root .. ' rev-parse HEAD')[1]
  local remote_url = vim.fn.systemlist('git -C ' .. git_root .. ' config --get remote.origin.url')[1]

  -- 1. Convert SSH URLs to HTTPS (git@github.com:user/repo.git -> https://github.com/user/repo)
  remote_url = remote_url:gsub('git@github.com:', 'https://github.com/')

  -- 2. Strip username/token from HTTPS URLs (https://me@github.com -> https://github.com)
  remote_url = remote_url:gsub('://[^@]+@', '://')

  -- 3. Remove trailing .git
  remote_url = remote_url:gsub('%.git$', '')

  return remote_url, commit_hash, relative_path
end

local function generate_github_link(opts)
  local remote, commit, path = get_git_info()

  if not remote then return end

  local start_line = opts.line1
  local end_line = opts.line2
  local range_str = ""

  if opts.range == 2 then
    range_str = "#L" .. start_line .. "-L" .. end_line
  else
    range_str = "#L" .. start_line
  end

  local url = string.format("%s/blob/%s/%s%s", remote, commit, path, range_str)

  vim.fn.setreg('+', url)
  print("Copied to clipboard: " .. url)
end

vim.api.nvim_create_user_command('GitLink', generate_github_link, { range = true })
