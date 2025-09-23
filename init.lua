local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.g.codeium_server_config = { portal_url= "https://codingbuddy.onprem.gic.ericsson.se", api_url= "https://codingbuddy.onprem.gic.ericsson.se/_route/api_server" }
--
require("options-config")
require("lazy").setup("plugins")

