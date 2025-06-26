require("einstein")
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({ import = "lazy/plugins" }, { change_detection = { notify = false } })

-- require("colorizer").setup()
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.opt.colorcolumn = ""
vim.api.nvim_set_hl(0, "StatusLine", { fg = "NONE", bg = "NONE" })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

vim.o.background = "dark" -- or "light" for light mode

vim.cmd.colorscheme("kanagawa")
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "kanagawa",
	callback = function()
		if vim.o.background == "light" then
			vim.fn.system("kitty +kitten themes Kanagawa_light")
		elseif vim.o.background == "dark" then
			vim.fn.system("kitty +kitten themes Kanagawa_dragon")
		else
			vim.fn.system("kitty +kitten themes Kanagawa")
		end
	end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>h", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-a>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<C-s>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<C-d>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<C-f>", function()
	ui.nav_file(4)
end)
vim.cmd("highlight Keyword cterm=bold gui=bold")
vim.cmd("highlight Function cterm=bold gui=bold")

require("lspconfig").html.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("lspconfig").tsserver.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(client, bufnr)
		-- Your on_attach function to set keybindings, etc.
	end,
	flags = {
		debounce_text_changes = 150,
	},
})

vim.keymap.set("n", "<leader>ai", vim.lsp.buf.code_action, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.py", "*.go" }, -- Add your file types
	callback = function()
		vim.lsp.buf.code_action({
			apply = true,
			context = { only = { "source.addMissingImports" } }, -- Filter only auto-import actions
		})
	end,
})
local lspconfig = require("lspconfig")
local ts = require("typescript")

ts.setup({
	debug = false, -- set to true for verbose logging
	disable_commands = false, -- we want the plugin commands to be created
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition if necessary
	},
	server = {
		on_attach = function(client, bufnr)
			-- Optionally override keymaps for tsserver here
			local opts = { noremap = true, silent = true }
			vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>TypescriptGoToSourceDefinition<CR>", opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rf", "<cmd>TypescriptRenameFile<CR>", opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>oi", "<cmd>TypescriptOrganizeImports<CR>", opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ru", "<cmd>TypescriptRemoveUnused<CR>", opts)
		end,
	},
})
