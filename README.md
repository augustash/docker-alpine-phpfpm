# Alpine PHP-FPM Image

![https://www.augustash.com](http://augustash.s3.amazonaws.com/logos/ash-inline-color-500.png)

**This base container is not currently aimed at public consumption. It exists as a starting point for August Ash containers.**

## Versions

- `1.0.0`, `latest` [(Dockerfile)](https://github.com/augustash/docker-alpine-phpfpm/blob/1.0.0/Dockerfile)

[See VERSIONS.md for image contents.](https://github.com/augustash/docker-alpine-phpfpm/blob/master/VERSIONS.md)

## Usage

This image provides the ability to run single, one-off commands as well as a long running PHP-FPM process. Run a single command like this:

```bash
docker run --rm \
    augustash/alpine-phpfpm php -v
```

For single-use PHP commands, you can skip the S6-Overlay process like this:

```bash
docker run --rm \
    --entrypoint /usr/bin/php \
    augustash/alpine-phpfpm --version
```

### PHP Configuration

The image is prepared in a way to make it relatively easy to customize PHP. Custom PHP configuration should be added to `/etc/php7/conf.d/` or `/etc/php7/php-fpm.d/`.

```bash
docker run --rm \
    -v $(pwd)/conf/www.conf:/etc/php7/php-fpm.d/www.conf \
    -v $(pwd)/conf/php.ini:/etc/php7/conf.d/php.ini \
    augustash/alpine-phpfpm php -i
```

### Included Extensions

These PHP extensions are enabled:

- `bcmath`
- `curl`
- `gd`
- `iconv`
- `intl`
- `json`
- `mbstring`
- `mcrypt`
- `opcache`
- `pdo`
- `pdo_mysql`
- `redis`
- `soap`
- `xml`
- `xsl`
- `zip`

### User/Group Identifiers

To help avoid nasty permissions errors, the container allows you to specify your own `PUID` and `PGID`. This can be a user you've created or even root (not recommended).

### Environment Variables

The following variables can be set and will change how the container behaves. You can use the `-e` flag, an environment file, or your Docker Compose file to set your preferred values. The default values are shown:

- `PUID`=501
- `PGID`=1000
- `COMPOSER_HOME`=/.composer

## Inspiration

- [fballiano](https://github.com/fballiano/)
- [joshporter](https://github.com/joshporter)
- [meanbee](https://github.com/meanbee/)
