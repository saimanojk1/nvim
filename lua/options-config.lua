vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd('nnoremap ,y "+yy')
vim.cmd('vnoremap p "_dP`]')
vim.cmd('nnoremap p p`]')

-- Yank and paste from clipboard
vim.cmd('nnoremap ,y "+y')
vim.cmd('vnoremap ,y "+y')
vim.cmd('nnoremap ,yy "+yy')
vim.cmd('nnoremap ,p "+p')

-- have x (removes single character) not go into the default registry
vim.cmd('nnoremap x "_x')
-- Make X an operator that removes without placing text in the default registry
vim.cmd('nmap X "_d')
vim.cmd('nmap XX "_dd')
vim.cmd('vmap X "_d')
vim.cmd('vmap x "_d')

-- don't yank to default register when changing something
vim.cmd('nnoremap c "xc')
vim.cmd('xnoremap c "xc')

-- Floating Window borders
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
-- Leader key space
vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})

-- Diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>;", vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>'", vim.diagnostic.goto_next, { noremap = true, silent = true })
-- Optional: Set a keymap to show all diagnostics in a quickfix list
vim.keymap.set("n", "<leader>q", function()
  vim.diagnostic.setqflist()
end, { noremap = true, silent = true })

-- Copy paste to clipboard
--vim.keymap.set(
