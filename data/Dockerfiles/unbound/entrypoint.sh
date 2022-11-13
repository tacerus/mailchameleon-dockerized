#!/bin/sh
set -Ceu

printf 'Init 1 ..\n'
/usr/sbin/unbound-anchor -v

printf 'Init 2 ..\n'
/usr/sbin/unbound-control-setup 2>/dev/null

printf 'Init 3 ..\n'
for file in /hooks/*; do
  if [ -x "${file}" ]; then
    echo "Running hook ${file}"
    "${file}"
  fi
done

printf 'Init Ok.\n'

exec "$@"
