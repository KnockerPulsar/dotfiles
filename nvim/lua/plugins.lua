require('packer_init')
require('lsp_init')
require('cmp_init')

require('nvim_comment').setup()
require('mason').setup()
require("mason-lspconfig").setup()
require("which-key").setup()

require('command-completion').setup{
	use_matchfuzzy = false,
	tab_completion = false
}

require('vgit').setup()

local telescope_config = {
	defaults = {
		path_display = { "truncate" },
		layout_config = {
			width = 0.9,
			height = 0.9
		},
		file_ignore_patterns = { '.git' }
	},
	pickers = {
		find_files  = { hidden = true },
		colorscheme = { enable_preview = true }
	}
}

local snippy_config = {
	mappings = {
		is = {
			['<Tab>'] = 'expand_or_advance',
		},
		nx = {
			['<leader>x'] = 'cut_text',
		},
	},
}

local indent_blankline_config = {
	char = "",
	context_char = "│",
	show_current_context = true,
	show_current_context_start = true,
	show_trailing_blankline_indent = false,
}

local nvim_treesitter_configs = {
	ensure_installed = { "c", "cpp", "lua", "rust", "python", "java", "javascript", "bash", "php" },
}

local lualine_config = {
	options = {
		section_separators = { left = '', right = '' },
		component_separators = { left = '|', right = '|' }
	}
}

local configs = {
	['telescope'] = telescope_config,
	['snippy'] = snippy_config,
	['indent_blankline'] = indent_blankline_config,
	['nvim-treesitter.configs'] = nvim_treesitter_configs,
	['lualine'] = lualine_config
}

for pkg, config in pairs(configs) do
	require(pkg).setup(config)
end

local wk = require('which-key')

-- Maps 
-- <leader> a => "Align"
-- <leader> a c => "To character"
-- <leader> a s => "To string"
wk.register({
		a = {
			name = "Align",
			c = "To character",
			s = "To string"
		}
	},
	{prefix = vim.g.mapleader}
	)
