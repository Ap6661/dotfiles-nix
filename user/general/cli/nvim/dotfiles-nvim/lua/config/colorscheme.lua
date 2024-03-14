-- return {
--   "EdenEast/nightfox.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.opt.background = "dark"
--     vim.cmd.colorscheme "carbonfox"
--   end
-- }
--return {
--  "dracula/vim",
--   config = function()
--     vim.opt.background = "dark"
--     vim.cmd.colorscheme "dracula"
--   end
--}
return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.background = "dark"
    vim.cmd.colorscheme "catppuccin-macchiato"
  end
}
