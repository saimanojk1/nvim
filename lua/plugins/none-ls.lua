return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- Go
				null_ls.builtins.formatting.gofmt.with({
					filetypes = { "go" },
				}),
				null_ls.builtins.diagnostics.golangci_lint.with({
					filetypes = { "go" },
				}),
				-- Other languages
				null_ls.builtins.formatting.prettier.with({
					filetypes = { "javascript", "typescript", "json", "html", "css" },
				}),
				null_ls.builtins.completion.luasnip,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
