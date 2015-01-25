#!/bin/bash


if [[ ! -f /var/log/cloud-init.log ]]; then
echo "=> An empty or uninitialized cloud-init"
echo "=> executing CloudInit ..."
cloud-init init
echo "=> Done!"
else
cloud-init init
echo "=> initialized cloud-init Done!"
fi

echo "=> initialized ssh server Done!"
exec /usr/sbin/sshd -D