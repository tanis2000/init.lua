require("cmake-tools").setup {
  cmake_build_options = { "-j8" }, -- this will be passed when invoke `CMakeBuild`
}
