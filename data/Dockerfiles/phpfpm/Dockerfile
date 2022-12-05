FROM registry.suse.com/bci/bci-base:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

RUN set -eu ; \
	zypper ar https://download.opensuse.org/repositories/server:/php:/extensions/15.4/server:php:extensions.repo ; \
	zypper ar https://download.opensuse.org/repositories/home:/crameleon:/LibertaCasa:/Mail/15.4/home:crameleon:LibertaCasa:Mail.repo ; \
	zypper -n --gpg-auto-import-keys ref ; \
	zypper -n in ImageMagick jq redis mariadb-client \
		php8-fpm php8-redis php8-memcached php8-APCu php8-imagick php8-intl php8-exif php8-gd php8-mailparse ; \
	echo 'include=/etc/php8/fpm/php-fpm.d/*.conf' > /etc/php8/fpm/php-fpm.conf ; \
	mkdir /hooks

COPY entrypoint.sh /usr/local/sbin/

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]

CMD ["/usr/sbin/php-fpm"]
