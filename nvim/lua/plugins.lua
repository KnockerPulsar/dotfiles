require('packer_init')

local packer = require'packer'
local use = packer.use


require('lsp_init')

require('telescope').setup {
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

use {
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	end
}

