load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def loadIdrisPackages():
  git_repository(
      name = "idris-effects",
      remote = "https://github.com/shmish111/idris-effects.git",
      commit = "89068f067085e8f342a8a7c8809a543fcffd3f5e",
  )

  git_repository(
      name = "lightyear",
      remote = "https://github.com/shmish111/lightyear.git",
      commit = "9da02a121a17f0284ad2354fd809aea28847b6a8",
  )

  git_repository(
      name = "idris-contrib",
      remote = "https://github.com/shmish111/idris-contrib.git",
      commit = "58898db067da0af4c520bd46e3f3d8edd19ba226",
  )

  git_repository(
      name = "tomladris",
      remote = "https://github.com/shmish111/tomladris.git",
      commit = "8d8ce0d68341afedf4fced34e8a30702933a0681",
  )
