return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{

		"williamboman/mason-lspconfig.nvim",
		config = function()
			local border = {
				{ "🭽", "FloatBorder" },
				{ "▔", "FloatBorder" },
				{ "🭾", "FloatBorder" },
				{ "▕", "FloatBorder" },
				{ "🭿", "FloatBorder" },
				{ "▁", "FloatBorder" },
				{ "🭼", "FloatBorder" },
				{ "▏", "FloatBorder" },
			}

			-- To instead override globally
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			---@diagnostic disable-next-line: duplicate-set-field
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or border
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			-- LSP settings (for overriding per client)
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
			}
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					-- "volar",
					"gopls",
				},
				handlers = {
					function(server_name)
						if server_name ~= "jdtls" then
							vim.lsp.config[server_name] = {
								handlers = handlers,
							}
						end
					end,
				},
			})

			--[[ require("mason-lspconfig").setup_handlers({
        function(server_name)
          if server_name ~= "jdtls" then
            vim.lsp.config[server_name] = {
              handlers = handlers
            }
          end
        end,
        function()
          vim.lsp.config.pyright = {
            init_options = {
              pythonVersion = "3.10",
              pythonPlatform = "Linux",
              venvPath = "venv",
            },
          }
        end,
         volar = function()
          vim.lsp.config.volar = {
            typescript = {
              tsdk = "/home/saimanojk1/.nvm/versions/node/v22.13.1/lib/node_modules/typescript/lib"
            },
            vue = {
              hybridMode = false,
            },
          }
        end,
        ts_ls = function()
          local vue_typescript_plugin = require('mason-registry')
              .get_package('vue-language-server')
              :get_install_path()
              .. '/node_modules/@vue/language-server' .. '/node_modules/@vue/typescript-plugin'
          vim.lsp.config.ts_ls = {
            init_options = {
              typescript = {
                tsdk = "~/.nvm/versions/node/v22.13.1/lib/node_modules/typescript/lib"
              },
              vue = {
                hybridMode = false,
              },
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_typescript_plugin,
                  languages = { 'javascript', 'typescript', 'vue' }
                },
              }
            },
            filetypes = {
              'javascript',
              'javascriptreact',
              'javascript.jsx',
              'typescript',
              'typescriptreact',
              'typescript.tsx',
              'vue',
            },
          }
        end
      })  ]]
		end,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config.lua_ls = {
				capabilities = capabilities,
			}
			vim.lsp.config.ts_ls = {
				capabilities = capabilities,
			}
			vim.lsp.config.gopls = {
				capabilities = capabilities,
			}

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>df", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>rf", vim.lsp.buf.rename, { noremap = true, silent = true })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>ai", function()
				vim.lsp.buf.code_action({
					filter = function(action)
						return action.kind and string.match(action.kind, "source%.addMissingImports")
					end,
					apply = true,
				})
			end, {})
		end,
	},
}
