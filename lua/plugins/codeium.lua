return {}
--[[ return {
  "Exafunction/codeium.vim",
  version = "1.6.39",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  event = "BufEnter",
  opts = {
    api = {
      portal_url = '',
      host = '',
      path = '/_route/api_server'
    },
    enterprise_mode = true,
    enable_chat = true
  },
  config = function()
    vim.keymap.set('i', '<C-u>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
      { expr = true, silent = true })
    vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
      { expr = true, silent = true })
    vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  end
} ]]
