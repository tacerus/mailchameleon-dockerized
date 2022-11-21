FROM bci/python:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

COPY olefy.py /usr/local/bin/

RUN set -eu ; \
	zypper ar https://download.opensuse.org/repositories/home:/crameleon:/LibertaCasa/15.4/home:crameleon:LibertaCasa.repo ; \
	zypper --gpg-auto-import-keys -n ref ; \
	zypper -n in python310-magic python310-oletools; \
	zypper -n clean -a ; \
	useradd -rUd /var/lib/empty -s /sbin/nologin olefy ; \
	chown olefy:olefy /usr/local/bin/olefy.py


USER olefy

CMD ["python3", "-u", "/usr/local/bin/olefy.py"]
