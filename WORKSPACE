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

load("//:packages.bzl", "loadIdrisPackages")

loadIdrisPackages()
