local vim = vim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


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

	'nvim-lua/plenary.nvim',
	'nvim-lua/telescope.nvim',
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

	"blazkowolf/gruber-darker.nvim",

	{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
	{ 'nvim-treesitter/nvim-treesitter-context' },
	{ 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } },

	'tpope/vim-fugitive',
	'sbdchd/neoformat',
}

-- startup and add configure plugins
return packer.startup(function()
	use	'wbthomason/packer.nvim'

	-- Use plugins (for plugins that are unlikely to change, their configs can be found in `plugins.lua` )
	for _, thing in ipairs(packer_stuff) do
		use(thing)
	end

	-- Plugins under testing, once I think they're good for daily use, will be split to a declaration above and a more (or less) detailed config.
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
				default_mappings = true;
			}
		end
	}

	use {
		"windwp/nvim-autopairs",
		config = function()
			-- https://github.com/mrjones2014/dotfiles/blob/master/nvim/lua/my/configure/autopairs.lua
			local Rule = require('nvim-autopairs.rule')
			local npairs = require('nvim-autopairs')
			local cond = require('nvim-autopairs.conds')
			npairs.setup({})
			-- <> pair for generics and stuff,
			-- complete <> if the preceding text is alphanumeric or :: for Rust
			npairs.add_rule(Rule('<', '>', {
				-- *exclude* these filetypes so that nvim-ts-autotag works instead
				'-html',
				'-javascriptreact',
				'-typescriptreact',
			}):with_pair(cond.before_regex('%a+:?:?$', 3)):with_move(function(opts)
				return opts.char == '>'
			end))
		end
	}

        use {
                "ThePrimeagen/refactoring.nvim",
                requires = {
                        { "nvim-lua/plenary.nvim" },
                        { "nvim-treesitter/nvim-treesitter" }
                },
                config = function()
                        require('refactoring').setup()
                end
        }

        use "github/copilot.vim"

        use {
                "CopilotC-Nvim/CopilotChat.nvim",
                requires = {
                        { "nvim-lua/plenary.nvim" },

                }
        }

	if packer_bootstrap then
		require('packer').sync()
	end
end
)

