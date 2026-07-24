-- Bootstrap lazy.nvim (Automatic install if not present)
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

-- Initialize lazy.nvim
require("lazy").setup({
  spec = {
    -- This tells lazy.nvim to look in the lua/plugins folder for plugin files
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } }, -- Fallback colorscheme
  checker = { enabled = true },              -- Automatically check for updates
})

