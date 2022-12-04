FROM bci/bci-base:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

RUN set -eu ; \
        zypper -n ar https://download.opensuse.org/repositories/home:/crameleon:/LibertaCasa:/Mail/15.4/home:crameleon:LibertaCasa:Mail.repo ; \
        zypper --gpg-auto-import-keys -n ref ; \
	zypper -n in --no-recommends \ 
		mariadb-client redis jq bind-utils whois smtp-cli \
		nagios-plugins-tcp nagios-plugins-http nagios-plugins-ping nagios-plugins-mysql nagios-plugins-dns nagios-plugins-disk ; \ 
	zypper -n clean -a

COPY watchdog.sh /usr/local/bin/watchdog.sh
COPY check_mysql_slavestatus.sh /usr/lib/nagios/plugins/check_mysql_slavestatus.sh

CMD /usr/local/bin/watchdog.sh
