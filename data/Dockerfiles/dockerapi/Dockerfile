FROM bci/python:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

RUN set -eu ; \
	zypper ar https://download.opensuse.org/repositories/home:/crameleon:/LibertaCasa/15.4/home:crameleon:LibertaCasa.repo ; \
	zypper --gpg-auto-import-keys -n ref ; \
	zypper -n in --no-recommends docker python310-docker python310-Flask python310-Flask-RESTful ; \
	zypper -n clean -a

COPY dockerapi.py /usr/local/bin/

CMD ["python3", "-u", "/usr/local/bin/dockerapi.py"]
