# Smoke Hill

Smoke Hill is where Idris and his family live. It is also a package index for Idris libraries.

## How does it help

Package sets are a way out of "dependency hell". We look at all the libraries in our ecosystem and find a version for each library that works with all the others. We can then publish this for other people to use in their project, they can use any libraries they need and know that they will all work together.

## How can I use Smoke Hill in my project

Smoke Hill is a bazel-based project, it is designed to be used by other bazel projects. Using [rules_idris](https://github.com/BryghtWords/rules_idris) add the following to your `WORKSPACE` file:

```python
git_repository(
    name = "smoke-hill",
    remote = "https://github.com/shmish111/smoke-hill.git",
    commit = "73addb298b9b4d3cb7188c03627ff36ed16cd932",
)
load("@smoke-hill//:packages.bzl", "loadIdrisPackages")
loadIdrisPackages()
```

Now you can access dependencies in your `BUILD` files like this:

```python
load("@rules_idris//idris:rules_idris.bzl", "idris_library")

idris_library (
    name = "my-lib",
    deps = ["@idris-effects//:effects"],
    srcs = native.glob(["**/*.idr"]),
    visibility = ["//visibility:public"],
)
```

## Why not just use nixpkgs

This path has already been trodden by the Haskell community and [Tweag have written about it in some detail](https://www.tweag.io/posts/2018-03-15-bazel-nix.html), the same arguments apply directly to Idris.

## Contributing

If you are the maintainer of an Idris library, it's very simple to add it to Smoke Hill.

1. Make sure you can build the project with Bazel and that all dependencies are also in Smoke hill
2. Fork the smoke-hill github repository
3. Add your repository to the [loadIdrisPackages function](https://github.com/shmish111/smoke-hill/blob/master/packages.bzl#L3)
4. Add your package to [the dummy project BUILD file deps](https://github.com/shmish111/smoke-hill/blob/master/BUILD.bazel#L8)
5. Create a pull request

##
TODO:

* Add to CI build
* Push to a remote cache
