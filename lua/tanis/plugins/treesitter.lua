return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  },
  {
    "nvim-treesitter/playground",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
  }
}
