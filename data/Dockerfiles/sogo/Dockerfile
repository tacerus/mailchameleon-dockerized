FROM registry.suse.com/bci/bci-base:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

RUN set -eu ; \
        zypper -n ar https://download.opensuse.org/repositories/home:/crameleon:/LibertaCasa:/Mail/15.4/home:crameleon:LibertaCasa:Mail.repo ; \
        zypper --gpg-auto-import-keys -n ref ; \
	zypper -n in --no-recommends mariadb-client rsync supervisor syslog-ng-redis netcat-openbsd sogo-activesync ; \
	zypper -n clean -a ; \
	mkdir /hooks

COPY supervisord.conf /etc/supervisor/
COPY ["syslog-ng.conf", "syslog-ng-redis_slave.conf", "/etc/syslog-ng/"]
COPY ["entrypoint.sh", "bootstrap-sogo.sh", "stop-supervisor.sh", "/usr/local/sbin/"]

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
