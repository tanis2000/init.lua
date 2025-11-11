-- Flutter tools
return {
  'akinsho/flutter-tools.nvim',
  config = function()
    require("flutter-tools").setup {}   -- use defaults
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',   -- optional for vim.ui.select
  },
}
