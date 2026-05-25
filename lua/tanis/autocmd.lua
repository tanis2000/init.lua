-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Setup LSP commands',
  group = vim.api.nvim_create_augroup('lsp-attach-commands', { clear = true }),
  callback = function(e)
    local opts = { buffer = e.buf, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
      vim.tbl_extend("force", opts, { desc = "[G]oto [D]efinition" }))
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, vim.tbl_extend("force", opts, { desc = "Hover" }))
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
      vim.tbl_extend("force", opts, { desc = "[V]iew [W]orkspace [S]ymbol" }))
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
      vim.tbl_extend('force', opts, { desc = "[V]iew [D]iagnostic" }))
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end,
      vim.tbl_extend('force', opts, { desc = "Goto previous" }))
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end,
      vim.tbl_extend('force', opts, { desc = "Goto next" }))
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
      vim.tbl_extend('force', opts, { desc = "[V]iew [C]ode [A]ction" }))
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
      vim.tbl_extend('force', opts, { desc = "[V]iew [R]eferences, all [R]eferences" }))
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
      vim.tbl_extend('force', opts, { desc = "[V]iew [R]ename [N]" }))
    vim.keymap.set("i", "<C-y>", function() vim.lsp.buf.signature_help() end,
      vim.tbl_extend('force', opts, { desc = "Signature help" }))
  end
})

vim.filetype.add({
  extension = {
    avsc = 'json'
  }
})
