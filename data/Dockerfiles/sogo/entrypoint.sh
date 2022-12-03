#!/bin/bash

if [[ "${SKIP_SOGO}" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
  echo "SKIP_SOGO=y, skipping SOGo..."
  sleep 365d
  exit 0
fi

if [[ ! -z ${REDIS_SLAVEOF_IP} ]]; then
  cp /etc/syslog-ng/syslog-ng-redis_slave.conf /etc/syslog-ng/syslog-ng.conf
fi

# Run hooks
for file in /hooks/*; do
  if [ -x "${file}" ]; then
    echo "Running hook ${file}"
    "${file}"
  fi
done

# Rsync web content
echo "Syncing web content with named volume"
rsync -a /usr/lib64/GNUstep/SOGo/. /sogo_web/

# Chown backup path
chown -R sogo:sogo /sogo_backup

exec "$@"
