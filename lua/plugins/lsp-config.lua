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
        ensure_installed =
        {
          "lua_ls",
          'tsserver',
          'volar',
        },

      })
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          if server_name ~= "jdtls" then
            require("lspconfig")[server_name].setup {
              handlers = handlers
            }
          end
        end,
        volar = function()
          require('lspconfig').volar.setup({})
        end,
        tsserver = function()
          local vue_typescript_plugin = require('mason-registry')
              .get_package('vue-language-server')
              :get_install_path()
              .. '/node_modules/@vue/language-server'
              .. '/node_modules/@vue/typescript-plugin'

          require('lspconfig').tsserver.setup({
            init_options = {
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
          })
        end
      })
    end,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>df", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
