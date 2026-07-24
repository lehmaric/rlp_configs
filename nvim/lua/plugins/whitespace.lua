return {
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      -- Highlight whitespace by default
      vim.g.better_whitespace_enabled = 1

      -- Strip whitespace on save (optional, but very useful)
      -- You can disable this if you prefer using conform.nvim for cleaning
      vim.g.strip_whitespace_on_save = 1

      -- Don't show whitespace in certain file types (like binaries or help)
      vim.g.better_whitespace_filetypes_blacklist = {
        'diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown'
      }

      -- Custom keymap to strip whitespace manually
      vim.keymap.set('n', '<leader>sw', ':StripWhitespace<CR>', { desc = 'Strip Trailing Whitespace' })
    end
  }
}

