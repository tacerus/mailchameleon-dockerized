#!/bin/sh
set -Ceu

printf 'Init 1 ..\n'
/usr/sbin/unbound-anchor -a /var/lib/unbound/root.key -v

printf 'Init 2 ..\n'
/usr/sbin/unbound-control-setup 2>/dev/null
etcdir='/etc/unbound'
cp /etc/unbound/unbound_{control,server}.{key,pem} /var/lib/unbound/etc/unbound/

printf 'Init 3 ..\n'
hintsfile='/var/lib/unbound/root.hints'
if [ ! -f "$hintsfile" ]
then
	curl -sSo "$hintsfile" https://www.internic.net/domain/named.root
fi

printf 'Init 4 ..\n'
rundir='/run/unbound'
if [ ! -d "$rundir" ]
then
	mkdir "$rundir"
fi

printf 'Init 5 ..\n'
for file in /hooks/*; do
  if [ -x "${file}" ]; then
    echo "Running hook ${file}"
    "${file}"
  fi
done

printf 'Init Ok.\n'

exec "$@"
