FROM registry.suse.com/bci/bci-base:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

COPY unbound-nobloat.expect /tmp/install

RUN set -eu ; \
	zypper al systemd sudo ; \
	zypper -n ar https://download.opensuse.org/repositories/home:/crameleon:/LibertaCasa:/Mail/15.4/home:crameleon:LibertaCasa:Mail.repo ; \
	zypper --gpg-auto-import-keys -n ref ; \ 
	zypper -n in expect ; \
	expect /tmp/install ; rm /tmp/install ; \
	zypper -n clean -a ; \
	sed -i -e 's/# use-syslog:.*/use-syslog: no/' /etc/unbound/unbound.conf ; \
	mkdir /hooks

EXPOSE 53/udp 53/tcp

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]

CMD ["/usr/sbin/unbound", "-dv"]
