return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5', -- Use a stable version
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } -- Makes searching even faster
    },
    config = function()
      local builtin = require('telescope.builtin')

      -- Keymaps to make searching fast
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

      -- Search specifically in your config files (very useful!)
      vim.keymap.set('n', '<leader>en', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Edit Neovim config' })
    end
  }
}

