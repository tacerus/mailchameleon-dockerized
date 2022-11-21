#!/bin/bash

if [[ "${SKIP_SOLR}" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
  echo "SKIP_SOLR=y, skipping Solr..."
  sleep 365d
  exit 0
fi

MEM_TOTAL=$(awk '/MemTotal/ {print $2}' /proc/meminfo)

if [[ "${1}" != "--bootstrap" ]]; then
  if [ ${MEM_TOTAL} -lt "2097152" ]; then
    echo "System memory less than 2 GB, skipping Solr..."
    sleep 365d
    exit 0
  fi
fi

set -e

solrenv='/etc/solr/solr.in.sh'
solrenv2="$solrenv.local"
solrconfdir='/usr/share/solr/server/solr/configsets/_default/conf'
datadir='/var/lib/solr/dovecot-fts'
logdir='/var/log/solr'
solrbin='/usr/bin/solr'

echo 'SOLR_HEAP=' > "$solrenv2"
if [[ "${1}" != "--bootstrap" ]]; then
  sed '/SOLR_HEAP=/c\SOLR_HEAP="'${SOLR_HEAP:-1024}'m"' "$solrenv2" > /tmp/heapenv
else
  sed '/SOLR_HEAP=/c\SOLR_HEAP="256m"' "$solrenv2" > /tmp/heapenv
fi
cat /tmp/heapenv > "$solrenv2"
rm /tmp/heapenv

echo "Preparing Solr environment ..."
set -a
. "$solrenv"
. "$solrenv2"
SOLR_SERVER_DIR="$SOLR_SERVER_DIR/server"
unset LOG4J_PROPS
set +a

if [[ "${1}" == "--bootstrap" ]]; then
  echo "Creating initial configuration"

  echo "Modifying default config set"
  cp /etc/solr/solr-config-7.7.0.xml "$solrconfdir/solrconfig.xml"
  cp /etc/solr/solr-schema-7.7.0.xml "$solrconfdir/schema.xml"
  rm "$solrconfdir/managed-schema"

  # hacks; to-do
  echo "Modifying Solr binary ..."
  sed -i -e '/CMS/d' -e '/UseConcMarkSweepGC/d' -e '/SOLR_TIP=`dirname/d' -e 's?SOLR_TIP=`cd.*?SOLR_TIP="/usr/share/solr"?' "$solrbin"

  echo "Starting local Solr instance to setup configuration"
  $solrbin start -v -V -force

  until solr status
  do
	  echo "Waiting for Solr to get ready ..."
	  sleep 5s
  done

  echo "Creating core \"dovecot-fts\""
  $solrbin create -c dovecot-fts -p 8983 -V -force

  # See https://github.com/docker-solr/docker-solr/issues/27
  echo "Checking core"
  while ! wget -O - 'http://localhost:8983/solr/admin/cores?action=STATUS' | grep -q instanceDir; do
    echo "Could not find any cores, waiting..."
    sleep 3
  done

  echo "Created core \"dovecot-fts\""

  echo "Stopping local Solr"
  $solrbin stop -p 8983 -V

  echo "Setting permissions"
  chown -R solr "$datadir"
  chown -R solr "$logdir"
  chown solr "$solrenv2"

  exit 0
fi

exec $solrbin start -f

