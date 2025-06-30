vim.cmd("highlight Function cterm=bold gui=bold")
vim.cmd("highlight Keyword cterm=bold gui=bold")

vim.diagnostic.config({
	virtual_text = {
		source = "always", -- "if_many" to show only if multiple sources
	},
})

-- set the indentation in php
vim.cmd("filetype indent on")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "php",
	callback = function()
		vim.opt_local.indentexpr = ""
		vim.opt_local.autoindent = true
	end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.number = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmode = false
vim.opt.colorcolumn = ""

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = true
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.laststatus = 3

vim.opt.tabstop = 2 -- Number of visual spaces per TAB
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use spaces instead of tabs

vim.api.nvim_create_user_command("LspClients", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	if #clients == 0 then
		print("No LSP clients attached")
	else
		local names = {}
		for _, client in ipairs(clients) do
			table.insert(names, client.name)
		end
		print("Attached LSPs: " .. table.concat(names, ", "))
	end
end, {})
