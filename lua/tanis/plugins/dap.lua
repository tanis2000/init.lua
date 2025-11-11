-- Debug adapter
return {

  {
    'mfussenegger/nvim-dap',
    lazy = false,
    config = function()
      local dap = require('dap')
      dap.set_log_level("DEBUG")

      dap.adapters.lldb = {
        type = 'executable',
        command = '/opt/homebrew/opt/llvm/bin/lldb-dap', -- adjust as needed, must be absolute path
        name = 'lldb'
      }

      dap.configurations.cpp = {
        {
          type = 'lldb',
          request = 'launch',
          name = 'Launch file',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.odin = dap.configurations.cpp

      dap.configurations.java = {
        {
          type = 'java',
          request = 'launch',
          name = 'Launch java application',
          modulePaths = {},
          classPaths = {},
        }
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003
        }
      }

      dap.configurations.go = {
        {
          type = "delve",
          request = "launch",
          name = "Launch go application"
        }
      }
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "delve", "php" },
        automatic_installation = true,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
          delve = function(config)
            table.insert(config.configurations, 1, {
              args = function() return vim.split(vim.fn.input("args> "), " ") end,
              type = "delve",
              name = "file",
              request = "launch",
              program = "${file}",
              outputMode = "remote",
            })
            table.insert(config.configurations, 1, {
              args = function() return vim.split(vim.fn.input("args> "), " ") end,
              type = "delve",
              name = "file args",
              request = "launch",
              program = "${file}",
              outputMode = "remote",
            })
            require("mason-nvim-dap").default_setup(config)
          end,
        }
      })
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      dap.listeners.after.event_output.dapui_config = function(_, body)
        if body.category == "console" then
          dapui.eval(body.output) -- Sends stdout/stderr to Console
        end
      end
    end
  },
  {
    'nvim-telescope/telescope-dap.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('telescope').load_extension('dap')
    end
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  }
}
