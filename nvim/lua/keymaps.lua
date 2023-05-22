local vim = vim

local NS = { noremap = true, silent = true }
local NV = { 'n', 'v' }
local NVI = { 'n', 'v', 'i' }
local NVT = { 'n', 'v', 't' }
AlignChar = function() require'align'.align_to_char(1, false) end
AlignString = function() require'align'.align_to_string(false, false) end

local key_mapper = function(mode, key, result, options)
	vim.keymap.set(
		mode,
		key,
		result,
		options or NS
	)
end

vim.g.mapleader = ' '

-- { { modes }, 'desired_keys', 'result_keys' }
local custom_keys = {
	{
		't',
		'<Esc>',
		'<C-\\><C-n>'
	},
	{
		'n',
		'<M-d><M-d>',
		'"_dd'
	},
	{
		NV,
		'<M-d>',
		'"_d'
	},
	{
		'n',
		'<M-c><M-c>',
		'V"_c'
	},
	{
		NV,
		'<M-c>',
		'"_c'
	},
	{
		'n',
		'gd',
		':lua vim.lsp.buf.definition()<CR>'
	},
	{
		'n',
		'gD',
		':lua vim.lsp.buf.declaration()<CR>'
	},
	{
		'n',
		'gi',
		':lua vim.lsp.buf.implementation()<CR>'
	},
	{
		'n',
		'gw',
		':lua vim.lsp.buf.document_symbol()<CR>'
	},
	{
		'n',
		'gW',
		':lua vim.lsp.buf.workspace_symbol()<CR>'
	},
	{
		'n',
		'gr',
		':lua vim.lsp.buf.references()<CR>'
	},
	{
		'n',
		'gt',
		':lua vim.lsp.buf.type_definition()<CR>'
	},
	{
		NV ,
		'K',
		':lua vim.lsp.buf.hover()<CR>'
	},
	{
		'n',
		'<C-k>',
		':lua vim.lsp.buf.signature_help()<CR>'
	},
	{
		'n',
		'<leader>f',
		':lua require"telescope.builtin".find_files()<CR>'
	},
	{
		'n',
		'<leader>b',
		':lua require"telescope.builtin".buffers()<CR>'
	},
	{
		NV,
		',',
		':lua vim.lsp.buf.code_action()<CR>'
	},
	{
		'n',
		'<leader>rn',
		':lua vim.lsp.buf.rename()<CR>'
	},
	{
		'n',
		'<leader>rg',
		':lua require"telescope.builtin".live_grep()<CR>'
	},
	{
		'n',
		'<leader>gw',
		':lua require"telescope.builtin".grep_string()<CR>'
	},
	{
		'x',
		'<leader>ac',
		AlignChar,
		NS
	},
	{
		'x',
		'<leader>as',
		AlignString,
		NS
	},
	{ NV, '<C-u>', "<C-u>zz" },
	{ NV, '<C-d>', "<C-d>zz" },
	{
		'n',
		'<leader><tab>',
		function ()
			require('telescope-tabs').list_tabs()
		end
	},
	{ NV, '<M-h>', '<C-w>h' },
	{ NV, '<M-l>', '<C-w>l' },
	{ NV, '<M-j>', '<C-w>j' },
	{ NV, '<M-k>', '<C-w>k' },

	{ NVT, '<C-h>', '5<C-w><' },
	{ NVT, '<C-l>', '5<C-w>>' },
	{ NVT, '<C-j>', '5<C-w>+' },
	{ NVT, '<C-k>', '5<C-w>-' },

	{ NV, '<C-n>', ':NextError<CR>' },
	{ NV, '<C-p>', ':PrevError<CR>' },

	{ 'n', '<M-1>', ':1tabnext<CR>'},
	{ 'n', '<M-2>', ':2tabnext<CR>'},
	{ 'n', '<M-3>', ':3tabnext<CR>'},
	{ 'n', '<M-4>', ':4tabnext<CR>'},

	{ 'n', '<backspace>', function() vim.cmd [[ToggleTerm direction=vertical size=60]] end }
}

if vim.g.neovide then
	-- { NVT, '<C-h>', '5<C-w><' },
	
	table.insert(
		custom_keys, { NVT, '<C-=>', function()
				vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
			end
		}
	)


	table.insert(
		custom_keys, { NVT, '<C-->',
			function()
				if vim.g.neovide_scale_factor > 0.5 then
				vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
				end
			end
		}
	)
end

--{	 'n' , '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>' },
for _, custom_bind in ipairs(custom_keys) do
	-- NOTE: This might break if neovim updates its LuaJIT
	local modes, desired_keys, result_keys, options = unpack(custom_bind)
	key_mapper(modes, desired_keys, result_keys, options)
end

