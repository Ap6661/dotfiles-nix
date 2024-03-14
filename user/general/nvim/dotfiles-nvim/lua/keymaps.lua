-- Common Options
local opts = {
  noremap = true,
  silent = true,
}


------------
-- Normal --
------------

-- Better Movement
vim.keymap.set('n', 'L', 'Lzz', opts)
vim.keymap.set('n', 'H', 'Hzz', opts)

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Terminal
if vim.fn.has('win32') == 1 then
  vim.keymap.set('n', '<Leader>t', ':vert bo new +term\\ powershell | set nonumber norelativenumber<cr>iclear<cr>', opts)
else
  vim.keymap.set('n', '<Leader>t', ':vert bo new +term\\ ' .. vim.opt.shell:get() .. ' | set nonumber norelativenumber<cr>iclear<cr>', opts)
end

-- Set spell check
vim.keymap.set('n', '<leader>ss', ':setlocal spell!<cr>', opts)

-- Paste from clipboard
vim.keymap.set('n', '<leader>p', '"+p', opts)

------------
-- Visual --
------------

-- Start Visual with the same area
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
