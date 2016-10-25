FROM composer/composer:alpine


RUN mkdir /kahlan

WORKDIR /kahlan

RUN composer selfupdate \
 && composer require "kahlan/kahlan:3.0.2" \
 && ln -s /kahlan/vendor/bin/kahlan /usr/local/bin/kahlan


WORKDIR /app

ENTRYPOINT ["/usr/local/bin/kahlan"]

CMD ["--help"]
