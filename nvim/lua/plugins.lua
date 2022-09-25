local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end


-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

local packer = require'packer'
local util = require'packer.util'

packer.init({
	package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

local use = packer.use
packer.reset()

--- startup and add configure plugins
packer.startup(function()
	use 'nvim-treesitter/nvim-treesitter'

	use {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
	}

	use 'nvim-lua/completion-nvim'
	use 'sheerun/vim-polyglot'

	-- these are optional themes but I hear good things about gloombuddy ;)
	-- colorbuddy allows us to run the gloombuddy theme
	use 'tjdevries/colorbuddy.nvim'
	use 'bkegley/gloombuddy'

	-- sneaking some formatting in here too
	use 'prettier/vim-prettier'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-lua/telescope.nvim'
	use 'jremmen/vim-ripgrep'

	use 'bluz71/vim-moonfly-colors'


	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'dcampos/cmp-snippy'

	use 'dcampos/nvim-snippy'
end
)

local lspconfig = require'lspconfig'
local completion = require'completion'

local function custom_on_attach(client)
	print('Attaching to ' .. client.name)
	completion.on_attach(client)
end

local default_config = {
	on_attach = custom_on_attach,
}

-- setup language servers here
lspconfig.tsserver.setup(default_config)
lspconfig.clangd.setup(default_config)

vim.g.mapleader = ' '

key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

key_mapper('n', '<leader>ff', ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

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

local cmp = require 'cmp'

cmp.setup({
		snippet = { 
			expand = function(args)
				require('snippy').expand_snippet(args.body)
			end
		}, 
		mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),

		sources = cmp.config.sources({
				{name = 'nvim_lsp'},
				{name = 'snippy'}
			},
			{name = 'buffer'})
	})

-- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
