#!/bin/bash


if [[ ! -f /var/log/cloud-init.log ]]; then
echo "=> An empty or uninitialized cloud-init"
echo "=> executing CloudInit ..."
cloud-init init > /dev/null 2>&1
echo "=> Done!"
else
cloud-init init
echo "=> initialized cloud-init Done!"
fi

exec /usr/sbin/sshd -D