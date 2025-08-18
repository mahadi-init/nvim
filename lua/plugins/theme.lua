return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_foreground = 'material'
    vim.g.gruvbox_material_disable_italic_comment = '1'
    vim.g.gruvbox_material_transparent_background = 1
    vim.cmd.colorscheme 'gruvbox-material'
  end,
}
