local lspconfig = require 'lspconfig'

local function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k, v in pairs(o) do
			if type(k) ~= 'number' then k = '"' .. k .. '"' end
			s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end

local function custom_on_attach(client)
	-- print('Attaching to ' .. client.name)

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

local cmp_config = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
cmp_config.on_attach = custom_on_attach


local pylsp_config = deepcopy(cmp_config)
pylsp_config['settings'] = {
	pylsp = {
		plugins = {
			pycodestyle = {
				ignore = { 'W293', 'W291', 'E302', 'E265', 'E116', 'E275' },
				maxLineLength = 120
			}
		}
	}
}

local lsp_configs = {
	['tsserver'] = cmp_config,
	['clangd'] = cmp_config,
	['jdtls'] = cmp_config,
	['lua_ls'] = cmp_config,
	['bashls'] = cmp_config,
	['rust_analyzer'] = cmp_config,
	['cmake'] = cmp_config,
	['html'] = cmp_config,
	['intelephense'] = cmp_config,
	['lemminx'] = cmp_config,
	['pylsp'] = pylsp_config,
	['marksman'] = cmp_config,
	-- ['opencl_ls'] = cmp_config
	['zls'] = cmp_config,
	['texlab'] = cmp_config
}

-- vim.lsp.set_log_level 'debug'

for lsp_name, lsp_config in pairs(lsp_configs) do
	lspconfig[lsp_name].setup(lsp_config)
end
