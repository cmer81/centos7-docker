# using the official image
FROM centos


# Upgraded ans install package by yum

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

# Execute script
CMD ["/run.sh"]