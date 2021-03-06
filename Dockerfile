# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates, and pre-requisites for SickRage
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum update -y; yum clean all
RUN yum install -y python-cheetah unzip supervisor git
RUN yum clean all

# Download and extract the latest SickRage release
RUN git clone https://github.com/SickRage/SickRage.git

ADD supervisord.conf /etc/supervisord.conf
ADD sickrage.ini /etc/supervisord.d/sickrage.ini
ADD start.sh /usr/sbin/start.sh
RUN chmod 755 /usr/sbin/start.sh

VOLUME /config
VOLUME /data
VOLUME /downloads

# Start sshd
EXPOSE 8081 9003
ENTRYPOINT ["/usr/sbin/start.sh"]
