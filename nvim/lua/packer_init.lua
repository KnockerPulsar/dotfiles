local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that packer is installed
-- local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
-- 	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
-- 	execute 'packadd packer.nvim'
-- end
--
local packer = require'packer'
local util = require'packer.util'

packer.init {
	package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
}

local use = packer.use
packer.reset()

local packer_stuff = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	'sheerun/vim-polyglot',

	'prettier/vim-prettier',
	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',
	'nvim-lua/telescope.nvim',
	'jremmen/vim-ripgrep',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'dcampos/cmp-snippy',
	'dcampos/nvim-snippy',
	"folke/which-key.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"terrortylor/nvim-comment",
	'mfussenegger/nvim-dap',
	'smolck/command-completion.nvim',

	"EdenEast/nightfox.nvim",
	'Shatur/neovim-ayu',
	'navarasu/onedark.nvim',
	'RRethy/nvim-base16',
	'tjdevries/colorbuddy.nvim',
	'bkegley/gloombuddy',
	"blazkowolf/gruber-darker.nvim",

	{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
	{ "bluz71/vim-moonfly-colors", as = "moonfly" },
	{ "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end },
	{ 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } },
	{ 'tanvirtin/vgit.nvim', requires = { 'nvim-lua/plenary.nvim' } },
	'Vonr/align.nvim'
}

--- startup and add configure plugins
return packer.startup(function()
	use	'wbthomason/packer.nvim'

	for _, thing in ipairs(packer_stuff) do
		use(thing)
	end

	use {
		'rmagatti/auto-session',
		config = function()
			require("auto-session").setup {
				log_level = "error",
				auto_session_suppress_dirs = { "~/" },
			}
		end
	}

	use {
		'LukasPietzschmann/telescope-tabs',
		requires = { 'nvim-telescope/telescope.nvim' },
		config = function()
			require'telescope-tabs'.setup{}
		end
	}

	use {
		"akinsho/toggleterm.nvim",
		tag = '*',
		config = function()
			require("toggleterm").setup()
		end
	}

	use {
		'crispgm/nvim-tabline',
		config = function ()
			require('tabline').setup({
					show_index = true,        -- show tab index
					show_modify = true,       -- show buffer modification indicator
					show_icon = false,        -- show file extension icon
					modify_indicator = '[+]', -- modify indicator
					no_name = 'No name',      -- no name buffer name
					brackets = { '[', ']' },  -- file name brackets surrounding
				})
		end
	}

	-- Lua
	use {
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

	use {
		'rmagatti/goto-preview',
		config = function()
			require('goto-preview').setup {
			lsp_configs = {}
		}
		end
	}

	use 'tpope/vim-fugitive'
end
)

