-- Set leader
vim.g.mapleader = " "

-- Lazy bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load your core configs
require("sets")
require("remaps")

vim.filetype.add({ extension = { ejs = "ejs" } })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ejs",
  callback = function()
    vim.bo.filetype = "ejs"
  end,
})

-- Load plugins (after filetype override is already in place)
require("lazy").setup("plugins")
