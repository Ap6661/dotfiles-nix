return {
  "ThePrimeagen/harpoon",
  dependencies = {
    {"nvim-lua/plenary.nvim"},
  },
  config = function ()
    vim.keymap.set('n', '<Leader>[',      ':lua require("harpoon.ui").toggle_quick_menu()<Cr>')
    vim.keymap.set('n', '<Leader><Tab>',  ':lua require("harpoon.mark").add_file()<Cr>')
    vim.keymap.set('n', '<C-v>',          ':lua require("harpoon.ui").nav_next()<cr>')
    vim.keymap.set('n', '<C-c>',          ':lua require("harpoon.ui").nav_prev()<cr>')
    vim.keymap.set('n', '<leader>1',      ':lua require("harpoon.ui").nav_file(1)<cr>')
    vim.keymap.set('n', '<leader>2',      ':lua require("harpoon.ui").nav_file(2)<cr>')
    vim.keymap.set('n', '<leader>3',      ':lua require("harpoon.ui").nav_file(3)<cr>')
  end
}
