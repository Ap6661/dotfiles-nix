return {
  "echasnovski/mini.nvim",
  version = false,
  config = function ()
    local opts = {
      noremap = true,
      silent = true,
    }
    require("mini.indentscope").setup()

    require("mini.map").setup()
    vim.keymap.set('n', '<Leader>m', ":lua MiniMap.toggle()<CR>", opts)

    require("mini.tabline").setup()
  end,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  }
}
