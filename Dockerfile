# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates, and pre-requisites for SickRage
RUN yum update -y; yum clean all
RUN yum install -y openssh-server
RUN yum install -y python-cheetah unzip
RUN rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
#    ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

# Download and extract the latest SickRage release
RUN curl -L https://github.com/SiCKRAGETV/SickRage/archive/master.zip -o /SickRage.zip
RUN unzip /SickRage.zip
RUN rm -f /SickRage.zip

VOLUME /config
VOLUME /downloads

# Set the root password to changeme
RUN echo "root:changeme" | chpasswd

# Start sshd
EXPOSE 22 8081
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
#ENTRYPOINT ["/SickRage-master/SickRage.py", "--config=/config/sickrage/config.ini"]
