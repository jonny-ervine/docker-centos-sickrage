# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates, and pre-requisites for SickRage
RUN yum update -y; yum clean all
#RUN yum install -y python-cheetah unzip openssh-server
RUN yum install -y python-cheetah unzip

#RUN rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
#    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
#    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key

# Download and extract the latest SickRage release
RUN curl -L https://github.com/SiCKRAGETV/SickRage/archive/master.zip -o /SickRage.zip
RUN unzip /SickRage.zip
RUN rm -f /SickRage.zip

#RUN echo "root:password" | chpasswd

VOLUME /config
VOLUME /data
VOLUME /downloads

# Start sshd
#EXPOSE 22 8081
EXPOSE 8081
#ENTRYPOINT ["/usr/sbin/sshd", "-D"]
ENTRYPOINT ["/SickRage-master/SickBeard.py", "--datadir=/config"]
