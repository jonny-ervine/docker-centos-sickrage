# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates, enable RPMFusion
RUN yum update -y; yum clean all
RUN yum install -y openssh-server
#RUN rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
#    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
#    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
#    ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

# Set the root password to changeme
RUN echo "root:changeme" | chpasswd

# Start sshd
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
