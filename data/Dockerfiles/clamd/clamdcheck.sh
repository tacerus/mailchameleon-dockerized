#!/bin/sh
set -eu

if [[ "${SKIP_CLAMD}" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
  echo "SKIP_CLAMD=y, skipping ClamAV..."
  exit 0
fi

if [ "${CLAMAV_NO_CLAMD:-}" != "false" ]; then
	if [ "$(echo "PING" | nc localhost 3310)" != "PONG" ]; then
		echo "ERROR: Unable to contact server"
		exit 1
	fi

	echo "Clamd is up"
fi

exit 0
