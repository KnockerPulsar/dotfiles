require('packer_init')

require('lsp_init')

require('telescope').setup {
	defaults = {
		path_display = { "smart" },
	},
	pickers = {
		find_files = { hidden = true }
	}
}

require('keymaps')

require('custom_commands')

require('mason').setup()
require("mason-lspconfig").setup()

require('snippy').setup({
		mappings = {
			is = {
				['<Tab>'] = 'expand_or_advance',
				['<S-Tab>'] = 'previous',
			},
			nx = {
				['<leader>x'] = 'cut_text',
			},
		},
	})

require('cmp_init')


-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

for lsp_name, _ in pairs(LspConfigs) do
	lspconfig[lsp_name].setup {
		capabilities = capabilities
	}
end

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "cpp", "lua", "rust", "python", "java", "javascript" },
}

require('nvim_comment').setup()
