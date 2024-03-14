return {
  'dundalek/lazy-lsp.nvim',
  enabled = vim.fn.executable('nix-shell') == 1, -- Only enable if Nix
  dependencies = {
    { "neovim/nvim-lspconfig" },
  },
  config = function()
    require("lazy-lsp").setup {
      prefer_local = true, -- Prefer locally installed servers over nix-shell

      default_config = {
        flags = {
          debounce_text_changes = 150,
        },
        -- on_attach = on_attach,
        -- capabilities = capabilities,
      },
      --
      -- Override config for specific servers that will passed down to lspconfig setup.
      -- Note that the default_config will be merged with this specific configuration so you don't need to specify everything twice.
      configs = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
            },
          },
        },
      },
    }
  end
}
