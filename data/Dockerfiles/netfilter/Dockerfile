FROM registry.suse.com/bci/python:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

RUN set -eu ; \
	zypper ar https://download.opensuse.org/repositories/home:/crameleon:/LibertaCasa/15.4/home:crameleon:LibertaCasa.repo ; \
	zypper --gpg-auto-import-keys -n ref ; \
	zypper -n in iptables python310-iptables python310-redis python310-dnspython ; \
	zypper -n clean -a

COPY server.py /usr/local/bin/
CMD ["python3", "-u", "/usr/local/bin/server.py"]
