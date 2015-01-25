# Not using the official image because it contains a fake package,
# "fakesystemd" which doesn't provide enough to actually do a build
FROM tuaris/centos-systemd

# systemd install fails in docker installs with AUFS backends so ensure
# they aren't upgraded by yum
RUN yum update -y
RUN yum -y install yum-plugin-versionlock
RUN yum versionlock add systemd
RUN yum versionlock add systemd-libs
RUN yum -y install fedora-packager git wget python-devel rpm-build rpmdevtools python-setuptools
RUN rpmdev-setuptree
RUN mkdir /build
WORKDIR /build
RUN git clone https://github.com/jayofdoom/cloud-init-fedora-pkg
WORKDIR cloud-init-fedora-pkg
RUN cp * /rpmbuild/SOURCES/
RUN wget -O /rpmbuild/SOURCES/cloud-init-0.7.5.tar.gz https://launchpad.net/cloud-init/trunk/0.7.5/+download/cloud-init-0.7.5.tar.gz
RUN rpmbuild -bb cloud-init.spec
RUN yum -y install openssh-server

CMD ["/usr/sbin/sshd", "-D"]