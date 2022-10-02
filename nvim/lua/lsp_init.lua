local lspconfig = require'lspconfig'
local completion = require'completion'


local function custom_on_attach(client)
	print('Attaching to ' .. client.name)
	completion.on_attach(client)
end

local default_config = {
	on_attach = custom_on_attach,
}

LspConfigs = {
	['tsserver'] = default_config,
	['clangd'] = default_config,
	['jdtls'] = default_config,
	['sumneko_lua'] = default_config,
	['pylsp'] = { settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						ignore = {'W391'},
						maxLineLength = 100
					}
				}
			}
		}
	},
}

for lsp_name, lsp_config in pairs(LspConfigs) do
	lspconfig[lsp_name].setup(lsp_config)
end

