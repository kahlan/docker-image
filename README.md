Kahlan Docker Image
===================

[![Build Status](https://travis-ci.org/kahlan/docker-image.svg?branch=master)](https://travis-ci.org/kahlan/docker-image) [![Docker Pulls](https://img.shields.io/docker/pulls/kahlan/kahlan.svg)](https://hub.docker.com/r/kahlan/kahlan)




## Supported tags and respective `Dockerfile` links

- [`4.7.2`, `4.7`, `4`, `latest`][101]
- [`4.7.2-php5`, `4.7-php5`, `4-php5`, `php5`][102]
- [`4.7.2-alpine`, `4.7-alpine`, `4-alpine`, `alpine`][103]
- [`4.7.2-php5-alpine`, `4.7-php5-alpine`, `4-php5-alpine`, `php5-alpine`][104]




## What is Kahlan?

Kahlan is a full-featured Unit & BDD test framework a la RSpec/JSpec which uses a describe-it syntax and moves testing in PHP one step forward.  
**Kahlan allows to stub or monkey patch your code directly like in Ruby or JavaScript without any required PECL-extentions.**

> [kahlan.github.io][Kahlan]

![Kahlan Logo](https://kahlan.github.io/docs/img/logo.png)




## How to use this image

Just map your working directory to `/app` inside container:
```bash
docker run --rm -v $(pwd):/app kahlan/kahlan
```

If you need to specify some options just do so:
```bash
docker run --rm -v $(pwd):/app kahlan/kahlan --help
docker run --rm -v $(pwd):/app kahlan/kahlan --config=my/kahlan-config.php
```

By default Kahlan is not running under [Xdebug or phpdbg, so code coverage doesn't work][6].  
If you require it, just use the wrapper you wish:
```bash
docker run --rm -v $(pwd):/app --entrypoint /kahlan-phpdbg kahlan/kahlan
docker run --rm -v $(pwd):/app --entrypoint /kahlan-xdebug kahlan/kahlan
```
Note, that `/kahlan-phpdbg` is not available in PHP5 image versions. See [why][5].




## Image versions

### `kahlan/kahlan:<version>`

This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It's built on top of [official PHP7 image][3].


### `kahlan/kahlan:<version>-php5`

This is made to run Kahlan under PHP5, rather than the default PHP7. It might be useful if you application still requires PHP5.

Note, that `phpdbg` is not available in this type of images. See [why][5].


### `kahlan/kahlan:<version>-alpine`

This image is based on the popular [Alpine Linux project][1], available in [the alpine official image][2]. Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.


### `kahlan/kahlan:<version>-php5-alpine`

This [Alpine][2]-based image is made to run Kahlan under PHP5.

Note, that `phpdbg` is not available in this type of images. See [why][5].




## License

[Kahlan] is licensed under [MIT license][91].

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

The [sources][7] for producing `kahlan/kahlan` Docker images are licensed under [MIT license][90] too.




## Issues

We can't notice comments in the DockerHub so don't use them for reporting issue or asking question.

If you have any problems with or questions about this image, please contact us through a [GitHub issue][80].





[Kahlan]: https://kahlan.github.io/docs

[1]: http://alpinelinux.org
[2]: https://hub.docker.com/_/alpine
[3]: https://hub.docker.com/_/php
[5]: https://github.com/kahlan/docker-image/issues/1#issuecomment-256260083
[6]: https://github.com/kahlan/kahlan#requirements
[7]: https://github.com/kahlan/docker-image
[80]: https://github.com/kahlan/docker-image/issues
[90]: https://github.com/kahlan/docker-image/blob/master/LICENSE.txt
[91]: https://github.com/kahlan/kahlan/blob/master/LICENSE.txt
[101]: https://github.com/kahlan/docker-image/blob/master/4/debian/Dockerfile
[102]: https://github.com/kahlan/docker-image/blob/master/4/php5-debian/Dockerfile
[103]: https://github.com/kahlan/docker-image/blob/master/4/alpine/Dockerfile
[104]: https://github.com/kahlan/docker-image/blob/master/4/php5-alpine/Dockerfile
