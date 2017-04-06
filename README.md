[![Build Status](https://travis-ci.org/kahlan/docker-image.svg?branch=master)](https://travis-ci.org/kahlan/docker-image)
[![Docker Pulls](https://img.shields.io/docker/pulls/kahlan/kahlan.svg)](https://hub.docker.com/r/kahlan/kahlan)
[![GitHub link](https://img.shields.io/badge/github-link-blue.svg)](https://github.com/kahlan/docker-image)
[![License](https://img.shields.io/github/license/kahlan/docker-image.svg)](https://github.com/kahlan/docker-image/blob/master/LICENSE.txt)




## Supported tags and respective `Dockerfile` links

- `3.1.11`, `3.1`, `3`, `latest` [(3.1/debian/Dockerfile)](https://github.com/kahlan/docker-image/blob/master/3.1/debian/Dockerfile)
- `3.1.11-php5`, `3.1-php5`, `3-php5`, `php5` [(3.1/php5-debian/Dockerfile)](https://github.com/kahlan/docker-image/blob/master/3.1/php5-debian/Dockerfile)
- `3.1.11-alpine`, `3.1-alpine`, `3-alpine`, `alpine` [(3.1/alpine/Dockerfile)](https://github.com/kahlan/docker-image/blob/master/3.1/alpine/Dockerfile)
- `3.1.11-php5-alpine`, `3.1-php5-alpine`, `3-php5-alpine`, `php5-alpine` [(3.1/php5-alpine/Dockerfile)](https://github.com/kahlan/docker-image/blob/master/3.1/php5-alpine/Dockerfile)




## What is Kahlan?

Kahlan is a full-featured Unit & BDD test framework a la RSpec/JSpec which uses
a describe-it syntax and moves testing in PHP one step forward.  
**Kahlan allows to stub or monkey patch your code directly like in Ruby or
JavaScript without any required PECL-extentions.**

> [kahlan.github.io](https://kahlan.github.io/docs/)

![Kahlan Logo](https://kahlan.github.io/docs/img/logo.png)




## How to use this image

Just map your working directory to `/app` inside container:
```
docker run --rm -v $(pwd):/app kahlan/kahlan
```

If you need to specify some options just do so:
```
docker run --rm -v $(pwd):/app kahlan/kahlan --help
docker run --rm -v $(pwd):/app kahlan/kahlan --config=my/kahlan-config.php
```

By default Kahlan is not running under [Xdebug or phpdbg, so code coverage
doesn't work](https://github.com/kahlan/kahlan#requirements).  
If you require it, just use the wrapper you wish:
```
docker run --rm -v $(pwd):/app --entrypoint /kahlan-phpdbg kahlan/kahlan
docker run --rm -v $(pwd):/app --entrypoint /kahlan-xdebug kahlan/kahlan
```
Note, that `/kahlan-phpdbg` is not available in PHP5 image versions.
See [why](https://github.com/kahlan/docker-image/issues/1#issuecomment-256260083).




## Image versions

### `kahlan/kahlan:<version>`

This is the defacto image. If you are unsure about what your needs are, you
probably want to use this one. It's built on top of
[official PHP7 image](https://hub.docker.com/_/php/).


### `kahlan/kahlan:<version>-php5`

This is made to run Kahlan under PHP5, rather than the default PHP7.
It might be useful if you application still requires PHP5.

Note, that `phpdbg` is not available in this type of images.
See [why](https://github.com/kahlan/docker-image/issues/1#issuecomment-256260083).


### `kahlan/kahlan:<version>-alpine`

This image is based on the popular [Alpine Linux project](http://alpinelinux.org/),
available in [the alpine official image](https://hub.docker.com/_/alpine).
Alpine Linux is much smaller than most distribution base images (~5MB), and
thus leads to much slimmer images in general.


### `kahlan/kahlan:<version>-php5-alpine`

This [Alpine](https://hub.docker.com/_/alpine)-based image is made to run
Kahlan under PHP5.

Note, that `phpdbg` is not available in this type of images.
See [why](https://github.com/kahlan/docker-image/issues/1#issuecomment-256260083).




## License

View [Kahlan MIT license](https://github.com/kahlan/kahlan/blob/master/LICENSE.txt).




## Issues

If you have any problems with or questions about this image, please contact us
through a [GitHub issue](https://github.com/kahlan/docker-image/issues).
