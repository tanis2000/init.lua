vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Generic finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Pretty list of quickfix including telescope
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        icons = false,
      }
    end
  }

  -- Color scheme
  use {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd("colorscheme tokyonight-night")
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }
  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-context");

  -- use {
  --   'VonHeikemen/lsp-zero.nvim',
  --   branch = 'v1.x',
  --   requires = {
  --     -- LSP Support
  --     { 'neovim/nvim-lspconfig' },
  --     { 'williamboman/mason.nvim' },
  --     { 'williamboman/mason-lspconfig.nvim' },
  --
  --     -- Autocompletion
  --     { 'hrsh7th/nvim-cmp' },
  --     { 'hrsh7th/cmp-buffer' },
  --     { 'hrsh7th/cmp-path' },
  --     { 'saadparwaiz1/cmp_luasnip' },
  --     { 'hrsh7th/cmp-nvim-lsp' },
  --     { 'hrsh7th/cmp-nvim-lua' },
  --
  --     -- Snippets
  --     { 'L3MON4D3/LuaSnip' },
  --     { 'rafamadriz/friendly-snippets' },
  --   }
  -- }

  use {
    "neovim/nvim-lspconfig",
    -- LSP Support
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    -- Autocompletion
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    -- Snippets
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  }

  use {
    "mfussenegger/nvim-jdtls",
    requires = {
      {
        "mfussenegger/nvim-dap"
      }
    }
  }

  -- Undo history visualizer
  use {
    "mbbill/undotree"
  }

  -- Git
  use("tpope/vim-fugitive")

  -- GitLab integration
  use { "shumphrey/fugitive-gitlab.vim" }

  -- GitHub integration
  use { "tpope/vim-rhubarb" }

  -- Zen mode
  use("folke/zen-mode.nvim")

  -- Lua nvim plugin development
  use("folke/neodev.nvim")

  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }

  -- Mini icons used by which-key
  use("echasnovski/mini.nvim")

  -- Key list popup window
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Comments
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Project manager
  -- use {
  --   "ahmedkhalf/project.nvim",
  --   config = function()
  --     require("project_nvim").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Debug adapter
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
  }
  use { 'nvim-telescope/telescope-dap.nvim',
    config = function()
      require('telescope').load_extension('dap')
    end
  }
  use { 'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup()
    end }

  -- Indent guides
  use "lukas-reineke/indent-blankline.nvim"

  -- JSON schemas
  use "b0o/schemastore.nvim"

  -- CMake Support
  -- use 'cdelledonne/vim-cmake'
  use 'Civitasv/cmake-tools.nvim'

  -- Flutter tools
  use {
    'akinsho/flutter-tools.nvim',
    config = function()
      require("flutter-tools").setup {} -- use defaults
    end,
    requires = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
  }

  -- Automatically create brackets
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

  -- Nice snapshots of the code you highlight (both gfx and ascii)
  use { 'mistricky/codesnap.nvim', run = 'make' }

  -- Move between files in an easy way without fuzzy find
  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } }
  }

  -- Best Go plugin
  use {
    'ray-x/go.nvim',
    'ray-x/guihua.lua',
    requires = {
      {
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter'
      }
    },
    config = function()
      require("go").setup()
    end
  }

  -- Gitsigns for diff, blame, etc
  use {
    'lewis6991/gitsigns.nvim',
  }

  -- Seeking in buffer
  use {
    'folke/flash.nvim'
  }
end)
