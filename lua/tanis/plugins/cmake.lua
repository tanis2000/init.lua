-- CMake Support
-- use 'cdelledonne/vim-cmake'
return {
  'Civitasv/cmake-tools.nvim',

  config = function()
    require("cmake-tools").setup {
      cmake_build_options = { "-j8" }, -- this will be passed when invoke `CMakeBuild`
    }
  end

}
