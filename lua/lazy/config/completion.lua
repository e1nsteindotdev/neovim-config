vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

--local lspkind = require("lspkind")
--lspkind.init({})

local cmp = require("cmp")

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert,noselect",
	},
	sources = {
		{ name = "nvim_lsp", priority = 1000 },
		{ name = "buffer", priority = 500 },
		{ name = "path", priority = 300 },
		{ name = "cody" },

		--{ name = "luasnip" },
		--{ name = "path" },
		--{ name = "tabnin-nvim" },
	},

	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
	},
})

cmp.setup.filetype({ "sql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
		-- { name = "nvim_lsp" },
		-- { name = "luasnip" },
		-- { name = "path" },
	},
})
