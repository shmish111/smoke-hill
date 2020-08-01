# Smoke Hill

[![Build Status](https://travis-ci.com/shmish111/smoke-hill.svg?branch=main)](https://travis-ci.com/shmish111/smoke-hill)

Smoke Hill is where Idris and his family live. It is also a package set for Idris libraries.

## How does it help

Package sets are a way out of "dependency hell". We look at all the libraries in our ecosystem and find a version for each library that works with all the others. We can then publish this for other people to use in their project, they can use any libraries they need and know that they will all work together.

## How can I use Smoke Hill in my project

Smoke Hill is currently built using nix however this is just out of convenience of caching. Smoke Hill is really just a list of git repositories and commits that all work together meaning you can use whatever tools you like to build your project, nix being just one of them. In fact we are currently in the process of building a package manager specifically for Idris that will make use of Smoke Hill.

## Contributing

If you are the maintainer of an Idris library, it's fairly simple to add it to Smoke Hill however if you have any problems, feel free to open a github issue.

1. Fork the smoke-hill github repository
2. Add your repository to the [package sources file](https://github.com/shmish111/smoke-hill/blob/master/nix/packae-sources.json)
3. Add your package to the [packages derivation](https://github.com/shmish111/smoke-hill/blob/master/nix/packages.nix)
4. Check that `nix-build -A packages` builds successfully. If you don't or can't use nix then you can create a PR anyway and Smoke-Hill maintainers will check things for you.
5. Create a pull request

## What's coming up

The direction that we intend to take with this is to make life as easy as possible for library maintainers. This means more and more automation will be added to Smoke Hill. The vision is that a library maintainer will only need to take action if they push to their main branch something that breaks the latest package set. Additionally there will be minimal intervention required by the package set maintainers, for example, collaboration would be required if the maintainer of a core library wished to make a breaking change that would affect multiple libraries in the package set.

Additionally the new build tool will be a core part of the ecosystem and will make use of Idris extremely easy.
