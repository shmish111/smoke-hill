load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
git_repository(
    name = "rules_idris",
    remote = "https://github.com/BryghtWords/rules_idris.git",
    tag = "v0.3"
)

load("@rules_idris//idris:idris_repos.bzl", "loadIdrisPackagerRepositories")

loadIdrisPackagerRepositories()

load("@rules_idris//idris:local_idris_loader.bzl", "loadIdris")

loadIdris("/nix/store/iz7jahxg47hzhwapiwlc2xr2nqsixdkq-idris-1.3.1")

git_repository(
    name = "idris-effects",
    remote = "https://github.com/shmish111/idris-effects.git",
    commit = "89068f067085e8f342a8a7c8809a543fcffd3f5e",
)

git_repository(
    name = "lightyear",
    remote = "https://github.com/shmish111/lightyear.git",
    commit = "bde456b8b564fa3086c08508063ec5ff170be47f",
)
