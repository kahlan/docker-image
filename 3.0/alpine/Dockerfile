FROM composer/composer:alpine


RUN mkdir /kahlan

WORKDIR /kahlan

RUN composer selfupdate \
 && composer require "kahlan/kahlan:3.0.2" \
 && ln -s /kahlan/vendor/bin/kahlan /usr/local/bin/kahlan \

 # Create handy wrapper for running kahlan with coverage
 && echo '#!/bin/sh' >> /usr/local/bin/kahlan-phpdbg \
 && echo 'exec /usr/local/bin/phpdbg -qrr /usr/local/bin/kahlan "$@"' \
                     >> /usr/local/bin/kahlan-phpdbg \
 && chmod +x /usr/local/bin/kahlan-phpdbg


WORKDIR /app

ENTRYPOINT ["/usr/local/bin/kahlan"]

CMD ["--help"]
