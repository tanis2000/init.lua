-- Pretty list of quickfix including telescope
return {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup {
      icons = false,
    }
  end
}
