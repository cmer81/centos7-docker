# Not using the official image because it contains a fake package,
# "fakesystemd" which doesn't provide enough to actually do a build
FROM tuaris/centos-systemd

# systemd install fails in docker installs with AUFS backends so ensure
# they aren't upgraded by yum
RUN yum update -y
RUN yum -y install openssh-server \
	passwd \
	hostname \
	cloud-init \
	net-tools

RUN cloud-init init

CMD ["/usr/sbin/sshd", "-D"]