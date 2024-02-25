return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = { "nvim-lua/plenary.nvim", },
  config = function ()
    vim.keymap.set('n', '<Leader><f1>', ':LazyGit<CR>', { noremap = true, silent = true } )
  end
}
