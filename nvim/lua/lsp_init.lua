-- http://lua-users.org/wiki/CopyTable
local function deepcopy(orig, copies)
	copies = copies or {}
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		if copies[orig] then
			copy = copies[orig]
		else
			copy = {}
			copies[orig] = copy
			for orig_key, orig_value in next, orig, nil do
				copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
			end
			setmetatable(copy, deepcopy(getmetatable(orig), copies))
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

local cmp_config = require('cmp_nvim_lsp').default_capabilities()

local pylsp_config = deepcopy(cmp_config)
pylsp_config['settings'] = {
	pylsp = {
		plugins = {
			pycodestyle = {
				ignore = { 'W293', 'W291', 'E302', 'E265', 'E116', 'E275' },
				maxLineLength = 120
			}
		}
	},
}

local luals_config = deepcopy(cmp_config)
luals_config['settings'] = {
	Lua = {
		runtime = {
			version = 'LuaJIT'
		},
		diagnostics = {
			globals = {'vim'}
		}
	}
}

local clangd_config = {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--function-arg-placeholders",
		"--completion-style=detailed",
		"--header-insertion=never"
	},
}

local lsp_configs = {
	['ts_ls'] = cmp_config,
	['clangd'] = clangd_config,
	['lua_ls'] = luals_config,
	['bashls'] = cmp_config,
	['rust_analyzer'] = cmp_config,
	['cmake'] = cmp_config,
	['html'] = cmp_config,
	['lemminx'] = cmp_config,
	['pylsp'] = pylsp_config,
	['marksman'] = cmp_config,
	['zls'] = cmp_config,
	['texlab'] = cmp_config,
	['robotframework_ls'] = cmp_config,
	['yamlls'] = cmp_config,
}

vim.lsp.set_log_level('warn')

for lsp_name, lsp_config in pairs(lsp_configs) do
        vim.lsp.config(lsp_name, lsp_config)
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })

            -- Disable LSP syntax highlight
            client.server_capabilities.semanticTokensProvider = nil
        end
    end
})

vim.diagnostic.config({virtual_lines = true})
