Kahlan Docker Image
===================

[![Build Status](https://travis-ci.org/kahlan/docker-image.svg?branch=master)](https://travis-ci.org/kahlan/docker-image) [![Docker Pulls](https://img.shields.io/docker/pulls/kahlan/kahlan.svg)](https://hub.docker.com/r/kahlan/kahlan)




## Supported tags and respective `Dockerfile` links

- `4.0.3`, `4.0`, `4`, `latest` [(4.0/debian/Dockerfile)][101]
- `4.0.3-php5`, `4.0-php5`, `4-php5`, `php5` [(4.0/php5-debian/Dockerfile)][102]
- `4.0.3-alpine`, `4.0-alpine`, `4-alpine`, `alpine` [(4.0/alpine/Dockerfile)][103]
- `4.0.3-php5-alpine`, `4.0-php5-alpine`, `4-php5-alpine`, `php5-alpine` [(4.0/php5-alpine/Dockerfile)][104]
- `3.1.18`, `3.1`, `3` [(3.1/debian/Dockerfile)][111]
- `3.1.18-php5`, `3.1-php5`, `3-php5` [(3.1/php5-debian/Dockerfile)][112]
- `3.1.18-alpine`, `3.1-alpine`, `3-alpine` [(3.1/alpine/Dockerfile)][113]
- `3.1.18-php5-alpine`, `3.1-php5-alpine`, `3-php5-alpine` [(3.1/php5-alpine/Dockerfile)][114]




## What is Kahlan?

Kahlan is a full-featured Unit & BDD test framework a la RSpec/JSpec which uses a describe-it syntax and moves testing in PHP one step forward.  
**Kahlan allows to stub or monkey patch your code directly like in Ruby or JavaScript without any required PECL-extentions.**

> [kahlan.github.io](https://kahlan.github.io/docs)

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

By default Kahlan is not running under [Xdebug or phpdbg, so code coverage doesn't work][6].  
If you require it, just use the wrapper you wish:
```
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

Kahlan itself is licensed under [MIT license][91].

Kahlan Docker Image is licensed under [MIT license][90] too.




## Issues

We can't notice comments in the DockerHub so don't use them for reporting issue or asking question.

If you have any problems with or questions about this image, please contact us through a [GitHub issue][80].





[1]: http://alpinelinux.org
[2]: https://hub.docker.com/_/alpine
[3]: https://hub.docker.com/_/php
[5]: https://github.com/kahlan/docker-image/issues/1#issuecomment-256260083
[6]: https://github.com/kahlan/kahlan#requirements
[80]: https://github.com/kahlan/docker-image/issues
[90]: https://github.com/kahlan/docker-image/blob/master/LICENSE.txt
[91]: https://github.com/kahlan/kahlan/blob/master/LICENSE.txt
[101]: https://github.com/kahlan/docker-image/blob/master/4.0/debian/Dockerfile
[102]: https://github.com/kahlan/docker-image/blob/master/4.0/php5-debian/Dockerfile
[103]: https://github.com/kahlan/docker-image/blob/master/4.0/alpine/Dockerfile
[104]: https://github.com/kahlan/docker-image/blob/master/4.0/php5-alpine/Dockerfile
[111]: https://github.com/kahlan/docker-image/blob/master/3.1/debian/Dockerfile
[112]: https://github.com/kahlan/docker-image/blob/master/3.1/php5-debian/Dockerfile
[113]: https://github.com/kahlan/docker-image/blob/master/3.1/alpine/Dockerfile
[114]: https://github.com/kahlan/docker-image/blob/master/3.1/php5-alpine/Dockerfile
