FROM bci/bci-base:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

COPY clamd.sh /usr/local/sbin/clamd.sh
COPY clamdcheck.sh /usr/local/bin/clamdcheck.sh

RUN set -eu ; \
  zypper -n in \
  rsync \
  bind-utils \
  clamav ; \
	chmod +x /usr/local/bin/clamdcheck.sh

HEALTHCHECK --start-period=6m CMD "/usr/local/bin/clamdcheck.sh"

ENTRYPOINT ["/usr/local/sbin/clamd.sh"]

CMD ["/usr/sbin/clamd", "-F"]
