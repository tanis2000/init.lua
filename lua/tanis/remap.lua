vim.g.mapleader = " "

-- Movement while inserting
vim.keymap.set("i", "<C-b>", '<ESC>^i', { desc = 'Move to beginning of line' })
vim.keymap.set("i", "<C-e>", '<End>', { desc = 'Move to end of line' })
vim.keymap.set("i", "<C-h>", '<Left>', { desc = 'Move left' })
vim.keymap.set("i", "<C-l>", '<Right>', { desc = 'Move right' })
vim.keymap.set("i", "<C-j>", '<Down>', { desc = 'Move down' })
vim.keymap.set("i", "<C-k>", '<Up>', { desc = 'Move up' })


-- Exec command
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Execute Command' })

-- Edit the packer file
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/<CR>",
  { desc = 'Edit the Packer config file' });

-- Execute the command on the highlighted line
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = 'Execute the command on the highlighted line' })

-- File save
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = 'Save file' })

-- File save without auto-format
vim.keymap.set("n", "<leader>W", "<cmd>noautocmd w<cr>", { desc = 'Save file without auto-format' })

-- File explorer
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = 'Open File Explorer' })

-- File find
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope builtin<cr>")
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>")
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>")
vim.keymap.set("n", "<leader>f.", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>")
vim.keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>")
vim.keymap.set("n", "<leader>fa", "<cmd>Telescope git_status<cr>")
vim.keymap.set("n", "<leader>ft", "<cmd>Telescope terms<cr>")
vim.keymap.set("n", "<leader>fi", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>")

-- Close buffer
vim.keymap.set("n", "<leader>bc", ":bdelete<CR>")

-- Git
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Comments
vim.keymap.set("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("n", "<C-?>", "<Plug>(comment_toggle_blockwise_current")
vim.keymap.set("x", "<C-/>", "<Plug>(comment_toggle_linewise_visual)")
vim.keymap.set("x", "<C-?>", "<Plug>(comment_toggle_blockwise_visual)")
vim.keymap.set("i", "<C-/>", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("i", "<C-?>", "<Plug>(comment_toggle_blockwise_current)")

-- Project
vim.keymap.set("n", "<leader>p", "<cmd>Telescope projects<cr>")

-- Quit confirmation and prohibit quit without saving on error
vim.keymap.set("n", "<leader>q", "<cmd>confirm q<CR>")
vim.keymap.set("n", "Q", "<nop>")

-- Formatting
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = 'Format buffer' })

-- Window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Move a line up/down
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = 'Move line down' })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = 'Move line up' })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = 'Move line down' })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = 'Move line up' })
vim.keymap.set("v", "<A-j>", "<cmd>m '>.+1<cr>gv-gv", { desc = 'Move line down' })
vim.keymap.set("v", "<A-k>", "<cmd>m '<.-2<cr>gv-gv", { desc = 'Move line up' })

-- Indent right/left
vim.keymap.set("n", "<A-h>", "<l", { desc = 'Indent left' })
vim.keymap.set("n", "<A-l>", ">l", { desc = 'Indent right' })
vim.keymap.set("i", "<A-h>", "<esc><lgi", { desc = 'Indent left' })
vim.keymap.set("i", "<A-l>", "<esc>>lgi", { desc = 'Indent right' })

-- CMake
vim.keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<cr>")
vim.keymap.set("n", "<leader>cc", "<cmd>CMakeClean<cr>")
vim.keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<cr>")
vim.keymap.set("n", "<leader>ct", "<cmd>CMakeToggle<cr>")


-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Copy to system clipboard' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Copy to system clipboard' })

-- Clear system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = 'Clear system clipboard' })

-- Terminal
vim.keymap.set("n", "<leader>st", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end, { desc = 'Open terminal' })

-- Diagnostic
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Quickfix movement
vim.keymap.set('n', '<C-j>', "<cmd>cnext<CR>zz", { desc = 'Move to next quickfix item' })
vim.keymap.set('n', '<C-k>', "<cmd>cprev<CR>zz", { desc = 'Move to previous quickfix item' })

-- List movement (uses the current window)
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = 'Move to next item in list' })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = 'Move to previous item in list' })

-- DAP
vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", { noremap = true, desc = 'Toggle DAP' })
vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true, desc = 'Toggle Breakpoint' })
vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { noremap = true, desc = 'Continue execution' })
vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>",
  { noremap = true, desc = 'Reset DAP' })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc='Step over'})
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, {desc='Step into'})
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, {desc='Step out'})
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end, {desc='Set breakpoint'})
vim.keymap.set('n', '<Leader>dlp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, {desc='Log point message'})
vim.keymap.set('n', '<Leader>dp', function() require('dap').repl.open() end, {desc='Repl'})
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, {desc='Run last'})
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, {desc='Hover'})
vim.keymap.set({'n', 'v'}, '<Leader>dv', function()
  require('dap.ui.widgets').preview()
end, {desc='Preview'})
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, {desc='Frames'})
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, {desc='Scopes'})

-- Harpoon
vim.api.nvim_set_keymap("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>",
  { noremap = true, desc = 'Toggle Harpoon' })

-- Move between buffers with tab/shift-tab
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Move to next buffer'})
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { desc = 'Move to previous buffer'})

-- WhichKey
vim.keymap.set('n', '<leader>wk', '<cmd>WhichKey<CR>', { desc = 'WhichKey all'})

-- Flash
vim.keymap.set({'n', 'x', 'o'}, 's', function() require("flash").jump() end, {desc='Flash'})
vim.keymap.set({'n', 'x', 'o'}, 'S', function() require("flash").treesitter() end, {desc='Flash Treesitter'})
vim.keymap.set('o', 'r', function() require("flash").remote() end, {desc='Remote Flash'})
vim.keymap.set({'o', 'x'}, 'R', function() require("flash").treesitter_search() end, {desc='Treesitter Search'})
vim.keymap.set('c', '<c-s>', function() require("flash").toggle() end, {desc='Toggle Flash'})
