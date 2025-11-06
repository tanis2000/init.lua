local home = os.getenv('HOME')
vim.uv.os_setenv("JAVA_HOME", home .. "/.jenv/versions/21.0")
local jdtls = require('jdtls')
local bundles = {
      vim.fn.glob(home .. "/Documents/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/Documents/vscode-java-test/server/*.jar", 1), "\n"))
local config = {
  cmd = {
    home .. '/.local/share/nvim/mason/bin/jdtls'
  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/",
          }
        }
      }
    }
  },
  init_options = {
    bundles = bundles
  },
  on_attach = function(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    jdtls.setup.add_commands()
    local opts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', "<A-o>", jdtls.organize_imports, opts)
    vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
    vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
    vim.keymap.set('n', "crv", jdtls.extract_variable, opts)
    vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
    vim.keymap.set('n', "crc", jdtls.extract_constant, opts)
  end
}
jdtls.start_or_attach(config)
