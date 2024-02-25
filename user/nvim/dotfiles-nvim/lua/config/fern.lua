return {
  'lambdalisue/fern.vim',
  dependencies = {
    { 'lambdalisue/fern-git-status.vim' },
    { 'lambdalisue/fern-renderer-nerdfont.vim' },
    { 'lambdalisue/nerdfont.vim' },
    { 'lambdalisue/glyph-palette.vim' },

  },
  config = function()
    vim.cmd("let g:fern#renderer = 'nerdfont'")
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "fern" },
      command = "call glyph_palette#apply()",
    })
    vim.keymap.set('n', '<Leader>-', ':Fern . -reveal=% -drawer -toggle<cr>',
      { noremap = true, silent = true })
  end
}
