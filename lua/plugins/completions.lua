return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local cmp = require("cmp")
      -- local lspkind = require("lspkind")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- formatting = {
        --    format = lspkind.cmp_format({
        --       mode = "symbol",
        --        maxwidth = 50,
        --         ellipsis_char = '...',
        --          symbol_map = { Codeium = "", }
        --         })
        --        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-3),
          ["<C-f>"] = cmp.mapping.scroll_docs(3),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          -- { name = "codeium" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
