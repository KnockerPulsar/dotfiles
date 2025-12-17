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


local function tanwiri_lualine_setup()
    local function get_hl(group, attr)
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        return hl[attr] and string.format("#%06x", hl[attr]) or "NONE"
    end

    -- Generate a theme object based on your current colorscheme
    local dynamic_tanwiri = {
        normal   = {
            -- Section A: Often the Mode (uses your TabLine selection style)
            a = { fg = get_hl('TabLineSel', 'fg'), bg = get_hl('TabLineSel', 'bg'), gui = 'bold' },
            -- Section B: Mid-left (uses your StatusLine colors)
            b = { fg = get_hl('StatusLine', 'fg'), bg = get_hl('StatusLine', 'bg') },
            -- Section C: The long middle bar (uses your TabLine background style)
            c = { fg = get_hl('TabLine', 'fg'), bg = get_hl('TabLine', 'bg') },
        },
        insert   = { a = { fg = get_hl('TabLineSel', 'fg'), bg = get_hl('TabLineSel', 'bg'), gui = 'bold' } },
        visual   = { a = { fg = get_hl('TabLineSel', 'fg'), bg = get_hl('TabLineSel', 'bg'), gui = 'bold' } },
        replace  = { a = { fg = get_hl('TabLineSel', 'fg'), bg = get_hl('TabLineSel', 'bg'), gui = 'bold' } },
        inactive = {
            a = { fg = get_hl('StatusLineNC', 'fg'), bg = get_hl('StatusLineNC', 'bg') },
            b = { fg = get_hl('StatusLineNC', 'fg'), bg = get_hl('StatusLineNC', 'bg') },
            c = { fg = get_hl('StatusLineNC', 'fg'), bg = get_hl('StatusLineNC', 'bg') },
        },
    }

    require('lualine').setup({
        options = {
            theme = dynamic_tanwiri,
            globalstatus = true,
            component_separators = '',
            section_separators = '',
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                'branch',
                {
                    'diff',
                    colored = true,
                    -- This is the key: Lualine will look for these groups in your .vim file
                    diff_color = {
                        added    = 'DiffAdd',
                        modified = 'DiffChange',
                        removed  = 'DiffDelete',
                    },
                }
            },
            lualine_c = { 'filename' },
            lualine_x = { 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        }
    })
end

local function setup_lualine()
    if vim.g.colors_name == "tanwiri" then
        tanwiri_lualine_setup()
    else
        require('lualine').setup {
            options = {
                section_separators = { left = '', right = '' },
                component_separators = { left = '|', right = '|' },
                theme = 'auto'
            }
        }
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(_)
        setup_lualine()
    end,
})

setup_lualine()


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
