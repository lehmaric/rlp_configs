return {
  {
    "hrsh7th/nvim-cmp",           -- The completion ENGINE. This is what provides the `cmp` module
    event = "InsertEnter",        -- Lazy-load: only pull it in the first time you enter Insert mode
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- Source: suggestions coming from your language servers (LSP)
      "hrsh7th/cmp-buffer",       -- Source: words already present in open buffers
      "hrsh7th/cmp-path",         -- Source: filesystem paths (e.g. after typing "./")
      "L3MON4D3/LuaSnip",         -- A snippet engine -- nvim-cmp requires one to be configured
      "saadparwaiz1/cmp_luasnip", -- Source: snippets from LuaSnip
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        -- nvim-cmp doesn't expand snippets itself; it hands them to a snippet
        -- engine. Here we tell it to use LuaSnip.
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Keys active while typing / while the completion menu is open.
        -- `preset.insert` gives sensible defaults; we override a few.
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),             -- manually open the menu
          ["<C-e>"] = cmp.mapping.abort(),                    -- close the menu, keep what you typed
          ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Enter: accept the highlighted item
          ["<C-n>"] = cmp.mapping.select_next_item(),         -- next suggestion
          ["<C-p>"] = cmp.mapping.select_prev_item(),         -- previous suggestion
        }),

        -- Where suggestions come from. The two groups are priority tiers:
        -- the second group is only consulted if the first yields nothing.
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
