require("dapui").setup()
local dap = require('dap')

require("mason-nvim-dap").setup({
    ensure_installed = { "python", "delve", "php" }
})

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
