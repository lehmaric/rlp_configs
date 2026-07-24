return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Adds pretty file icons
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto", -- Automatically matches your colorscheme
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          globalstatus = true, -- One single statusline at the bottom for all windows
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end,
  },
}

