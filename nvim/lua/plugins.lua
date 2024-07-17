require('packer_init')
require('cmp_init')

require('mason').setup()
require("mason-lspconfig").setup()
require('lsp_init')

require('nvim_comment').setup()
require('vgit').setup()

require('leap').add_default_mappings()

require("which-key").setup({
      window = { margin = { 1, 0, 0, 0.75 } },
      layout = { height = { min = 4, max = 80 } },
})

require('command-completion').setup{
	use_matchfuzzy = false,
	tab_completion = false
}

require('telescope').setup{
	defaults = {
		-- path_display = { "truncate" },
		layout_config = {
			width = 0.9,
			height = 0.9
		},
		file_ignore_patterns = { '.git', '.cache', "%.o", "%.mod", "%.ko", "%.symvers", "%.cmd" },
	},
	pickers = {
		find_files  = { hidden = true, theme = 'ivy' },
		buffers = { theme = 'ivy' },
		live_grep = { theme = 'ivy' },
		grep_string = { theme = 'ivy' },
		colorscheme = { enable_preview = true }
	}
}

require('snippy').setup{
	mappings = {
		is = {
			['<Tab>'] = 'expand_or_advance',
		},
		nx = {
			['<leader>x'] = 'cut_text',
		},
	},
}

require('nvim-treesitter.configs').setup{
    ensure_installed = { "c", "cpp", "lua", "rust", "python", "java", "javascript", "bash", "php", "typescript" },
    highlight = { enabled = true },
    indent = { enabled = true },
}

require('ibl').setup {
    indent = {
	smart_indent_cap = true
    },
    scope = { enabled = true, show_start = true }
}

require('lualine').setup {
	options = {
		section_separators = { left = '', right = '' },
		component_separators = { left = '|', right = '|' }
	}
}

require('which-key').register({
		a = {
			name = "Align",
			c = "To character",
			s = "To string"
		}
	},
	{ prefix = vim.g.mapleader }
)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if vim.tbl_contains({ 'null-ls' }, client.name) then  -- blacklist lsp
      return
    end
    require("lsp_signature").on_attach({
      -- ... setup options here ...
    }, bufnr)
  end,
})
