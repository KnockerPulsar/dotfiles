local cmp = require 'cmp'

cmp.setup {
	snippet = {
		expand = function(args)
			require('snippy').expand_snippet(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert({
			['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
			['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
				else
					fallback()
				end
			end)
		}),

	sources = cmp.config.sources {
		{name = 'nvim_lsp'},
		{name = 'snippy'}
	},
	{name = 'buffer'},
	completion = {
		completeopt = 'menu,menuone,noinsert'
	}
}
