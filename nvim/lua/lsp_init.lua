local pylsp_config = {
    settings = {

        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'W293', 'W291', 'E302', 'E265', 'E116', 'E275' },
                    maxLineLength = 120
                }
            }
        },
    }
}

local luals_config = {
    settings = {

        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            diagnostics = {
                globals = { 'vim' }
            }
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

local lsps_with_default_configs = {
    'ts_ls',
    'bashls',
    'rust_analyzer',
    'cmake',
    'html',
    'lemminx',
    'marksman',
    'zls',
    'texlab',
    'robotframework_ls',
    'yamlls',
}

local lsps_with_custom_configs = {
    ['clangd'] = clangd_config,
    ['lua_ls'] = luals_config,
    ['pylsp'] = pylsp_config,
}

vim.lsp.set_log_level('warn')

for lsp_name, lsp_config in pairs(lsps_with_custom_configs) do
    vim.lsp.config(lsp_name, lsp_config)
    vim.lsp.enable(lsp_name)
end

for _, lsp_name in ipairs(lsps_with_default_configs) do
    vim.lsp.enable(lsp_name)
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client:supports_method('textDocument/completion') then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

            -- Disable LSP syntax highlight
            client.server_capabilities.semanticTokensProvider = nil
        end
    end
})

vim.diagnostic.config({ virtual_lines = true })
