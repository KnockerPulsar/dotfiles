require('packer_init')
require('cmp_init')

require('mason').setup()
require("mason-lspconfig").setup()
require('lsp_init')

require('nvim_comment').setup()
-- require('vgit').setup()

require("which-key").setup({
	preset = "helix"
})

require('telescope').setup{
	defaults = {
		-- path_display = { "truncate" },
		layout_config = {
			width = 0.9,
			height = 0.9
		},
		file_ignore_patterns = { '.git', '.cache', "%.o", "%.mod", "%.ko", "%.symvers", "%.cmd" },
	},
	pickers = {
		find_files  = { hidden = true, theme = 'ivy' },
		buffers = { theme = 'ivy' },
		live_grep = { theme = 'ivy' },
		grep_string = { theme = 'ivy' },
		colorscheme = { enable_preview = true }
	}
}

require('nvim-treesitter.configs').setup{
    ensure_installed = { "c", "cpp", "lua", "rust", "python", "java", "javascript", "bash", "php", "typescript" },
    highlight = { enabled = true },
    indent = { enabled = true },
}

require('ibl').setup {
    indent = {
	smart_indent_cap = true
    },
    scope = { enabled = true, show_start = true }
}

require('lualine').setup {
	options = {
		section_separators = { left = '', right = '' },
		component_separators = { left = '|', right = '|' }
	}
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if vim.tbl_contains({ 'null-ls' }, client.name) then  -- blacklist lsp
      return
    end
    require("lsp_signature").on_attach({
      -- ... setup options here ...
    }, bufnr)
  end,
})
require('treesitter-context').setup {
	enable = true,     -- Enable this plugin (Can be enabled/disabled later via commands)
	multiwindow = true, -- Enable multiwindow support.
	max_lines = 3,     -- How many lines the window should span. Values <= 0 mean no limit.
	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	line_numbers = true,
	multiline_threshold = 20, -- Maximum number of lines to show for a single context
	trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	mode = 'cursor',   -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
	zindex = 20, -- The Z-index of the context window
	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
