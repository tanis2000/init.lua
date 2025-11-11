-- Nice snapshots of the code you highlight (both gfx and ascii)
return {
  'mistricky/codesnap.nvim',
  build = 'make',
  config = function()
    require("codesnap").setup({
      watermark = ""
    })
  end
}
