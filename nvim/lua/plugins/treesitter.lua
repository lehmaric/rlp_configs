return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",   -- classic API; the new "main" branch removed nvim-treesitter.configs
    build = ":TSUpdate", -- Automatically update parsers when you update the plugin
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        -- Add the languages you use frequently
        ensure_installed = { "lua", "vim", "vimdoc", "python", "markdown", "typescript" },

        highlight = { enable = true }, -- The "Magic" button for better colors
        indent = { enable = true },    -- Better auto-indentation based on code structure
      })
    end,
  },
}

