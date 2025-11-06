-- local root_files = {
--   '.luarc.json',
--   '.luarc.jsonc',
--   '.luacheckrc',
--   '.stylua.toml',
--   'stylua.toml',
--   'selene.toml',
--   'selene.yml',
--   '.git',
-- }
local home = os.getenv('HOME')

require("conform").setup({
  formatters_by_ft = {
  }
})
local cmp = require('cmp')
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  cmp_lsp.default_capabilities())

require("fidget").setup({})
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "gopls",
    "ols",
    "clangd"
  },
  automatic_enable = {
    exclude = {
      -- make sure we do not start jdtls as we use nvim-jdtls
      "jdtls"
    }
  },
  -- handlers = {
  --     function(server_name) -- default handler (optional)
  --         require("lspconfig")[server_name].setup {
  --             capabilities = capabilities
  --         }
  --     end,
  --
  --     zls = function()
  --         local lspconfig = require("lspconfig")
  --         lspconfig.zls.setup({
  --             root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
  --             settings = {
  --                 zls = {
  --                     enable_inlay_hints = true,
  --                     enable_snippets = true,
  --                     warn_style = true,
  --                 },
  --             },
  --         })
  --         vim.g.zig_fmt_parse_errors = 0
  --         vim.g.zig_fmt_autosave = 0
  --
  --     end,
  --     ["lua_ls"] = function()
  --         local lspconfig = require("lspconfig")
  --         lspconfig.lua_ls.setup {
  --             capabilities = capabilities,
  --             settings = {
  --                 Lua = {
  --                     format = {
  --                         enable = true,
  --                         -- Put format options here
  --                         -- NOTE: the value should be STRING!!
  --                         defaultConfig = {
  --                             indent_style = "space",
  --                             indent_size = "2",
  --                         }
  --                     },
  --                 }
  --             }
  --         }
  --     end,
  --     -- Java setup
  --     ['jdtls'] = function()
  --       local lspconfig = require('lspconfig')
  --       local bundles = { vim.fn.glob(home .. '/Documents/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'), }
  --       for _, bundle in ipairs(vim.split(vim.fn.glob(home .. '/Documents/vscode-java-test/server/*.jar'), '\n')) do
  --         table.insert(bundles, bundle)
  --       end
  --       require('jdtls').jol_path = home .. '/Documents/vscode-java-test/server/jol-cli.jar'
  --       local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
  --       extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  --       lspconfig.jdtls.setup {
  --         init_options = {
  --           bundles = bundles,
  --           extendedClientCapabilities = extendedClientCapabilities,
  --           --bundles = {
  --           --  vim.fn.glob("/Users/tanis/Documents/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
  --           --}
  --         }
  --       }
  --     end,
  -- }
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)               -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        end
        cmp.confirm()
      else
        fallback()
      end
    end, { "i", "s", }),
  }),
  sources = cmp.config.sources({
    { name = "copilot", group_index = 2 },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },             -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

vim.diagnostic.config({
  -- update_in_insert = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

-- Odin setup
vim.lsp.enable('ols')

-- dartls
vim.lsp.enable('dartls')

-- Integrate SchemaStore with LSP
vim.lsp.config('jsonls', {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})
vim.lsp.enable('jsonls')

vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
vim.lsp.enable('lua_ls')

vim.lsp.enable('wgsl_analyzer')

vim.diagnostic.config({
  virtual_text = true
})


--[[local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  -- 'tsserver',
  'rust_analyzer',
  'ols'
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})


-- Odin setup
require('lspconfig').ols.setup({})

-- dartls
require('lspconfig').dartls.setup({})

-- Integrate SchemaStore with LSP
require('lspconfig').jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
    vim.tbl_extend("force", opts, { desc = "[G]oto [D]efinition" }))
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, vim.tbl_extend("force", opts, { desc = "Hover" }))
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
    vim.tbl_extend("force", opts, { desc = "[V]iew [W]orkspace [S]ymbol" }))
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
    vim.tbl_extend('force', opts, { desc = "[V]iew [D]iagnostic" }))
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, vim.tbl_extend('force', opts, { desc = "Goto next" }))
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end,
    vim.tbl_extend('force', opts, { desc = "Goto previous" }))
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
    vim.tbl_extend('force', opts, { desc = "[V]iew [C]ode [A]ction" }))
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
    vim.tbl_extend('force', opts, { desc = "[V]iew [R]eferences [R]" }))
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
    vim.tbl_extend('force', opts, { desc = "[V]iew [R]ename [N]" }))
  vim.keymap.set("i", "<C-y>", function() vim.lsp.buf.signature_help() end,
    vim.tbl_extend('force', opts, { desc = "Signature help" }))
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
]] --
