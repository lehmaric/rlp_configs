return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      -- Capabilities advertise extra editor features (e.g. completion from
      -- nvim-cmp) to every language server we start.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- on_attach runs whenever a language server attaches to a buffer. It
      -- wires up LSP keymaps for THAT buffer only. Defined here, BEFORE it is
      -- referenced in the handlers below (Lua locals are only visible after
      -- their declaration).
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, remap = false }

        -- LSP Navigation and Information
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)                    -- Jump to the definition of the symbol under the cursor
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)                   -- Jump to the declaration of the symbol under the cursor
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)                          -- Display hover information about the symbol under the cursor
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)                    -- List all references to the symbol under the cursor
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)     -- Search for a symbol in the current workspace
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)             -- Display signature information in insert mode

        -- Diagnostics
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)         -- Show diagnostics in a floating window
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)                  -- Go to the previous diagnostic message
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)                  -- Go to the next diagnostic message

        -- LSP Actions
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)           -- Select a code action available at the current cursor position
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)                -- Rename all occurrences of the symbol under the cursor
        vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format { async = true } end, opts) -- Format the current buffer asynchronously
      end

      -- Initialize Mason (the package-installer UI).
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- Configure mason-lspconfig: which servers to auto-install, and how to
      -- start each one.
      mason_lspconfig.setup({
        ensure_installed = {
          "basedpyright",
          "ruff",
          "rust_analyzer",
          "clangd",
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
        },
      })

      vim.diagnostic.config(
        {
            virtual_text = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "󱈸",
                    [vim.diagnostic.severity.HINT] = "󰌵 ",
                    [vim.diagnostic.severity.INFO] = "i"
                }
            },
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = ""
            }
        }
    )
    end,
  },
}

