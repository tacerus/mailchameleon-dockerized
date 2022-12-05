FROM registry.suse.com/bci/bci-base:latest

LABEL maintainer "Georg Pfuetzenreuter <mail+containers@georg-pfuetzenreuter.net>"

COPY solr.sh /usr/local/sbin/
COPY solr-config-7.7.0.xml /etc/solr/
COPY solr-schema-7.7.0.xml /etc/solr/

RUN set -eu ; \
	zypper -n ar https://download.opensuse.org/repositories/home:/lrupp/15.4/home:lrupp.repo ; \
	zypper --gpg-auto-import-keys -n ref ; \
	zypper -n in solr wget lsof awk ; \
	zypper -n clean -a ; \
	chmod +x /usr/local/sbin/solr.sh ; \
        touch /etc/solr/solr.in.sh.local ; \
	/usr/local/sbin/solr.sh --bootstrap
  
USER solr
CMD ["/usr/local/sbin/solr.sh"]
