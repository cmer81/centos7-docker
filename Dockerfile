# Not using the official image because it contains a fake package,
# "fakesystemd" which doesn't provide enough to actually do a build
FROM centos

# systemd install fails in docker installs with AUFS backends so ensure
# they aren't upgraded by yum
RUN  yum clean all && yum update -y
RUN yum -y install openssh-server \
	passwd \
	hostname \
	cloud-init \
	net-tools

ADD run.sh /run.sh
RUN chmod 755 /run.sh

RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key 
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key 
RUN ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key

CMD ["/run.sh"]