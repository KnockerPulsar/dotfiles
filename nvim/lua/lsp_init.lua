local lspconfig = require'lspconfig'

local function custom_on_attach(client)
	print('Attaching to ' .. client.name)

	vim.api.nvim_create_autocmd("CursorHold", {
			buffer = bufnr,
			callback = function()
				local opts = {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = 'rounded',
					source = 'always',
					prefix = ' ',
					scope = 'cursor',
				}
				vim.diagnostic.open_float(nil, opts)
			end
		})
end

local default_config = {
	on_attach = custom_on_attach,
}

LspConfigs = {
	['tsserver'] = default_config,
	['clangd'] = default_config,
	['jdtls'] = default_config,
	['sumneko_lua'] = default_config,
	['bashls'] = default_config,
	['rust_analyzer'] = default_config,
	['cmake'] = default_config,
	['html'] = default_config,
	['intelephense'] = default_config,
	['lemminx'] = default_config
}

-- vim.lsp.set_log_level 'debug'

for lsp_name, lsp_config in pairs(LspConfigs) do
	lspconfig[lsp_name].setup(lsp_config)
end

lspconfig.pylsp.setup {
		settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = { 'W293', 'W291', 'E302', 'E265', 'E116', 'E275' },
					maxLineLength = 120
				}
			}
		}
	},
	on_attach = custom_on_attach
}
