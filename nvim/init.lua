-- Force Neovim and all subprocesses (LSPs) to use English
vim.env.LANG = "en_US.UTF-8"
vim.env.LC_ALL = "en_US.UTF-8"

-- Load basic settings
require("config.options")

-- Load keybindings
require("config.keymaps")

-- Load lazy.nvim (plugin manager)
require("config.lazy")

