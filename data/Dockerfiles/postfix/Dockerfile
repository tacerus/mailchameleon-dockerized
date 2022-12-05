FROM registry.suse.com/bci/bci-base:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

RUN set -eu ; \
	zypper -n ar https://download.opensuse.org/repositories/home:/crameleon:/LibertaCasa:/Mail/15.4/home:crameleon:LibertaCasa:Mail.repo ; \
        zypper --gpg-auto-import-keys -n ref ; \ 
	zypper -n in --no-recommends bind-utils mariadb-client postfix postfix-mysql redis syslog-ng-redis supervisor ; \
	zypper -n clean -a ; \
	printf '#!/usr/bin/bash\n/usr/sbin/postconf -c /opt/postfix/conf "$@"' > /usr/local/sbin/postconf ; \
	chmod +x /usr/local/sbin/postconf

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
COPY syslog-ng-redis_slave.conf /etc/syslog-ng/syslog-ng-redis_slave.conf
COPY postfix.sh /opt/postfix.sh
COPY rspamd-pipe-ham /usr/local/bin/rspamd-pipe-ham
COPY rspamd-pipe-spam /usr/local/bin/rspamd-pipe-spam
COPY whitelist_forwardinghosts.sh /usr/local/bin/whitelist_forwardinghosts.sh
COPY stop-supervisor.sh /usr/local/sbin/stop-supervisor.sh
COPY entrypoint.sh /usr/local/sbin/entrypoint.sh

RUN chmod +x /opt/postfix.sh \
  /usr/local/bin/rspamd-pipe-ham \
  /usr/local/bin/rspamd-pipe-spam \
  /usr/local/bin/whitelist_forwardinghosts.sh ; \
  rm -fr /tmp/*

EXPOSE 588

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
