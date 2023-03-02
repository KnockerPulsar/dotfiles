local vim = vim

local NS = { noremap = true, silent = true }
local NV = { 'n', 'v' }

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
		'x',
		'<leader>af',
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
		'' ,
		'gh',
		"^"
	},
	{
		'' ,
		'gl',
		"$"
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
	}
}

--{	 'n' , '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>' },
--
for _, custom_bind in ipairs(custom_keys) do
	-- NOTE: This might break if neovim updates its LuaJIT
	local modes, desired_keys, result_keys, options = unpack(custom_bind)
	key_mapper(modes, desired_keys, result_keys, options)
end

