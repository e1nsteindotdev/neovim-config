return {
	{ "datsfilipe/vesper.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "olivercederborg/poimandres.nvim", },
	{ "rose-pine/neovim", name = "rose-pine" },
	"rebelot/kanagawa.nvim",
	"folke/tokyonight.nvim",
	"Shatur/neovim-ayu",
	{ "catppuccin/nvim", name = "catppuccin" },
	"ricardoraposo/gruvbox-minor.nvim",
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_enable_italic = true
			vim.cmd.colorscheme("gruvbox-material")
		end,
	}

	}
