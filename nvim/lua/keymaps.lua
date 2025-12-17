local vim = vim

local NS = { noremap = true, silent = true }
local NV = { 'n', 'v' }
local NVI = { 'n', 'v', 'i' }
local NVT = { 'n', 'v', 't' }

local function align_char() require 'align'.align_to_char({ len = 1 }) end
local function align_string() require 'align'.align_to_string({ preview = false, regex = false }) end

local function get_cursor_row()
	local cursor = vim.api.nvim_win_get_cursor(0)
	return cursor[1]
end

-- https://www.reddit.com/r/neovim/comments/13mfta8/comment/jkwd0gb/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
local function format_selection()
	local vpos = vim.fn.getpos("v")
	local marker_row = vpos[2]
	local cursor_row = get_cursor_row()

	local _start = marker_row
	local _end = cursor_row

	if marker_row > cursor_row then
		_start, _end = _end, _start
	end

	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'm', false)
	vim.lsp.buf.format({ range = { _start, _end }, async = true })
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
		NV,
		'<M-d>',
		'"_d'
	},
	{
		NV,
		'<M-c>',
		'"_c'
	},
	{
		'n',
		'<leader>f',
                function() require('telescope.builtin').find_files() end
	},
	{
		'n',
		'<leader>b',
                function()
                        require("telescope.builtin").buffers({
                                show_all_buffers = true,
                                ignore_current_buffer = true,
                        })
                end
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
	-- {
	-- 	'n',
	-- 	'<leader><tab>',
	-- 	':lua require"telescope-tabs".list_tabs()<CR>'
	-- },
	{
		'x',
		'<leader>ac',
		align_char,
		NS
	},
	{
		'x',
		'<leader>as',
		align_string,
		NS
	},
	{ NV,  '<C-u>',       "<C-u>zz" },
	{ NV,  '<C-d>',       "<C-d>zz" },

	{ NV,  '<M-h>',       '<C-w>h' },
	{ NV,  '<M-l>',       '<C-w>l' },
	{ NV,  '<M-j>',       '<C-w>j' },
	{ NV,  '<M-k>',       '<C-w>k' },

	{ NVT, '<C-h>',       '5<C-w><' },
	{ NVT, '<C-l>',       '5<C-w>>' },
	{ NVT, '<C-j>',       '5<C-w>+' },
	{ NVT, '<C-k>',       '5<C-w>-' },

	{ 'n', '<leader>t1',       ':1tabnext<CR>' },
	{ 'n', '<leader>t2',       ':2tabnext<CR>' },
	{ 'n', '<leader>t3',       ':3tabnext<CR>' },

	{ 'n', '<backspace>', function() vim.cmd [[ToggleTerm direction=horizontal size=15]] end },

	{ 'v', '==',          format_selection, { noremap = true, silent = true, expr = true } },

        {
                'n',
                'gd',
                function() vim.lsp.buf.definition() end
        },
        {
                'n',
                'gD',
                function() vim.lsp.buf.declaration() end
        },
        {
                'n',
                '<leader>se',
                function() vim.diagnostic.open_float() end
        },
        {
                'i',
                '<C-space>',
                function() vim.lsp.completion.get() end
        }
}

for _, ck in ipairs(custom_keys) do
	local mode, key, result, options = ck[1], ck[2], ck[3], ck[4]
	vim.keymap.set(mode, key, result, options or NS)
end
