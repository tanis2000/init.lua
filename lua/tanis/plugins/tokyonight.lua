-- Color scheme
return {
  "folke/tokyonight.nvim",
  config = function()
    vim.cmd("colorscheme tokyonight-night")
    require('tokyonight').setup({
    })
  end
}
