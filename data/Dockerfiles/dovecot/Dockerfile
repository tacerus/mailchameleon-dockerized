FROM registry.suse.com/bci/bci-base:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

COPY dovecot-nobloat.expect /tmp/install

RUN set -eu ; \
	zypper al systemd ; \
	zypper -n ar https://download.opensuse.org/repositories/openSUSE:/Backports:/SLE-15-SP4/standard/openSUSE:Backports:SLE-15-SP4.repo ; \
	zypper -n ar https://download.opensuse.org/repositories/devel:/languages:/python/15.4/devel:languages:python.repo ; \
	zypper -n ar https://download.opensuse.org/repositories/home:/crameleon:/LibertaCasa:/Mail/15.4/home:crameleon:LibertaCasa:Mail.repo ; \ 
	zypper --gpg-auto-import-keys -n ref ; \
	zypper -n in \
  expect \
  curl \
  dirmngr \
  gettext-runtime \
  gpg2 \
  jq \
  mariadb-client \
  procps \
  redis \
  wget \
  python3-Jinja2 \
  python3-mysql-connector-python \
  python3-redis \
  html2text ; \
	expect /tmp/install ; rm /tmp/install ; \
	zypper -n in \
  dovecot23-backend-mysql \
  dovecot23-fts-solr \
  syslog-ng-redis ; \
	zypper -n clean -a ; \
	useradd -mrU vmail ; \
	mkdir /usr/lib/dovecot/sieve /hooks

COPY trim_logs.sh /usr/local/bin/trim_logs.sh
COPY clean_q_aged.sh /usr/local/bin/clean_q_aged.sh
COPY syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
COPY syslog-ng-redis_slave.conf /etc/syslog-ng/syslog-ng-redis_slave.conf
COPY imapsync /usr/local/bin/imapsync
COPY imapsync_runner.pl /usr/local/bin/imapsync_runner.pl
COPY report-spam.sieve /usr/lib/dovecot/sieve/report-spam.sieve
COPY report-ham.sieve /usr/lib/dovecot/sieve/report-ham.sieve
COPY rspamd-pipe-ham /usr/lib/dovecot/sieve/rspamd-pipe-ham
COPY rspamd-pipe-spam /usr/lib/dovecot/sieve/rspamd-pipe-spam
COPY sa-rules.sh /usr/local/bin/sa-rules.sh
COPY maildir_gc.sh /usr/local/bin/maildir_gc.sh
COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY stop-supervisor.sh /usr/local/sbin/stop-supervisor.sh
COPY quarantine_notify.py /usr/local/bin/quarantine_notify.py
COPY quota_notify.py /usr/local/bin/quota_notify.py
COPY repl_health.sh /usr/local/bin/repl_health.sh

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]
CMD exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
