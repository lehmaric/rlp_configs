-- ==============================================================================
-- CORE FUNCTIONALITY AND FILETYPE
-- ==============================================================================
-- vim.cmd("syntax on")              -- Enable syntax highlighting (Disable if nvim-treesiter is installed)
vim.opt.encoding = "utf-8"           -- Set file and terminal encoding to UTF-8

-- ==============================================================================
-- INDENTATION AND TABS (Using 4-space soft tabs)
-- ==============================================================================
vim.opt.autoindent = true           -- Copy indentation from the previous line
vim.opt.smartindent = true          -- Enable smarter automatic indentation
vim.opt.expandtab = true            -- Use spaces instead of actual tabs
vim.opt.tabstop = 4                 -- A Tab character is rendered as 4 spaces wide
vim.opt.shiftwidth = 4              -- Auto-indent commands (e.g., >>) use 4 spaces
vim.opt.softtabstop = 4             -- Tab/Backtab keys use 4 spaces when inserting

-- ==============================================================================
-- UI AND APPEARANCE
-- ==============================================================================
vim.opt.number = true               -- Show absolute line number
-- vim.opt.wildmenu = true          -- Enhanced command-line completion menu (Disable if nvim-cmp is installed)
vim.opt.mouse = "a"                 -- Enable mouse support
vim.opt.updatetime = 250            -- Sets the delay (ms) for showing diagnostics and tooltips (important for LSP)

-- ==============================================================================
-- SEARCH
-- ==============================================================================
vim.opt.path:append("**")           -- Allow searching for files recursively (e.g., :find filename)
vim.opt.incsearch = true            -- Show results as you type the search pattern (incremental search)
vim.opt.hlsearch = true             -- Highlight all matches of the last search pattern
vim.opt.ignorecase = false          -- Ignore case when searching
vim.opt.smartcase = true            -- Override ignorecase if the search pattern contains uppercase letters

-- ==============================================================================
-- BEHAVIOR AND SYSTEM INTEGRATION
-- ==============================================================================
vim.opt.backspace = "indent,eol,start" -- Ensures backspace works as expected
vim.opt.clipboard = "unnamedplus"      -- Integrate with system clipboard for yank/put (requires external tool)
vim.opt.swapfile = false               -- Disable swap files to prevent clutter
vim.opt.undofile = true                -- Enable persistent undo history

-- Specify a directory for undo files and create it if it doesn't exist
local undodir = vim.fn.expand("~/.config/nvim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

