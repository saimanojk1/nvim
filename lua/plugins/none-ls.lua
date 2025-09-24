return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		-- Function to get formatter dynamically
		local function get_sources_by_ft(ft)
			local sources = {
				go = { null_ls.builtins.formatting.gofmt },
			}
			return sources[ft] or { null_ls.builtins.formatting.prettier }
		end
		local ft = vim.bo.filetype -- Get current filetype
		local sources = get_sources_by_ft(ft)
		table.insert(sources, null_ls.builtins.completion.luasnip)

		null_ls.setup({
			sources = sources,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
