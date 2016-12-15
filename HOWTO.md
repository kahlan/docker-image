How to use and maintain this repository
=======================================

All operations are automated as much as possible.

- Images and description [on Docker Hub][1] will be automatically rebuilt on
  [pushes to `master` branch][2] and on updates of parent `php` Docker image.
- [Travis CI][3] is used only for tests.
- Generation of each `Dockerfile` and its context is automated via `Makefile`.



## Building

To build all possible versions locally, just run:
```
make everything
```

It will build all existing `Dockerfile`s and tag them with proper tags
([as `README.md` requires](README.md#supported-tags-and-respective-dockerfile-links)).



## Updating

To update versions of images following steps are required:

1.  Update all required versions in `Makefile`.
2.  Update all required versions in `README.md`.
3.  If you need to modify some `Dockerfile`s then do it via editing
    `Dockerfile-template.j2` Jinja2 template.
4.  Regenerate all `Dockerfile`s and their context (it's okay to remove previous
    ones completely):
    ```
    make all-docker-sources
    ```
5.  If `Dockerfile`s layout was changed somehow (major version change, for
    example), you should check [build triggers on Docker Hub][2] and modify
    `Dockerfile`s paths there as required BEFORE push to `master` branch.
6.  Push changes to `master` branch.



## Testing

To run tests for all possible image versions, just do:
```
make all-tests
```

It will build images for each `Dockerfile` and run those images against
`/test/suite.bats`.





[1]: https://hub.docker.com/r/kahlan/kahlan/tags
[2]: https://hub.docker.com/r/kahlan/kahlan/~/settings/automated-builds
[3]: https://travis-ci.org/kahlan/docker-image
