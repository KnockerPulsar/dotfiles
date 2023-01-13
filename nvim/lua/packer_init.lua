local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

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

	use 'kdheepak/lazygit.nvim'

	use "folke/which-key.nvim"
	

	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}


	use "lukas-reineke/indent-blankline.nvim"
	use "terrortylor/nvim-comment"

	use {"EdenEast/nightfox.nvim"}

	use 'mfussenegger/nvim-dap'
	use 'Shatur/neovim-ayu'
	use 'navarasu/onedark.nvim'

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
end
)

require("which-key").setup{}
