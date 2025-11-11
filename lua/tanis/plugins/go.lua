-- Best Go plugin
return {
  {
    'ray-x/go.nvim'
  },
  {
    'ray-x/guihua.lua',
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter'
      }
    },
    config = function()
      require("go").setup()
    end
  }
}
