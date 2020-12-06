# Smoke Hill

[![Build Status](https://travis-ci.com/shmish111/smoke-hill.svg?branch=main)](https://travis-ci.com/shmish111/smoke-hill)

Smoke Hill is where Idris and his family live. It is also a package set for Idris libraries.

## How does it help

Package sets are a way out of "dependency hell". We look at all the libraries in our ecosystem and find a version for each library that works with all the others. We can then publish this for other people to use in their project, they can use any libraries they need and know that they will all work together.

We believe that a community can be built _around_ a package set and with Idris we have the opportunity to do this in the early years to avoid conflicts with alternative ways of building a language ecosystem.

## How can I use Smoke Hill in my project

Smoke Hill is currently built using nix however this is just out of convenience and for caching. Smoke Hill is really just a list of git repositories and commits that all work together meaning you can use whatever tools you like to build your project, nix being just one of them. In fact we are currently in the process of adapting [Inigo](https://github.com/hayesgm/inigo) to make use of Smoke Hill.

If you are happy using nix, see [the example project](./example) for an idea of how to use Smoke Hill with nix (it's super easy).

## Contributing

If you are the maintainer of an Idris library, it's fairly simple to add it to Smoke Hill however at this time you need to have nix installed. If you have any problems or you can't/don't want to install nix then feel free to open a github issue and the maintainers can add it for you.

1. Fork the smoke-hill github repository
2. Run `nix-shell`
3. Add your repository using `niv -s ./nix/package-sources.json add githubuser/reponame -n package-name`. For more information on niv usage (for example your library is not hosted on github) see https://github.com/nmattia/niv
4. Find your package entry in [./nix/package-sources.json]() and add a list of dependencies. If there are no dependencies you will still need to add a `dependencies = [],` attribute.
5. Add your package to the [packages derivation](https://github.com/shmish111/smoke-hill/blob/master/nix/packages.nix) using the form `packagename = mkIdrisPackage "packagename" ps;`
6. Check that `nix-build -A packages` builds successfully.
7. Create a pull request with these changes.

## What's coming up

The direction that we intend to take with this is to make life as easy as possible for library users and maintainers. This means more and more automation will be added to Smoke Hill, for example this will include tooling to make it easy to add a library to the package set without needing to use nix.

The vision is that a library maintainer will only need to take action if they push to their main branch something that breaks the latest package set. Additionally there will be minimal intervention required by the package set maintainers, for example, collaboration would be required if the maintainer of a core library wished to make a breaking change that would affect multiple libraries in the package set.

Additionally the new build tool will be a core part of the ecosystem and will make use of Idris extremely easy.
