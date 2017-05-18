# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates, and pre-requisites for SickRage
RUN yum install -y http://mirror.pnl.gov/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum update -y; yum clean all
RUN yum install -y python-cheetah unzip supervisor
RUN yum clean all

# Download and extract the latest SickRage release
RUN curl -L https://github.com/SickRage/SickRage/archive/master.zip -o /SickRage.zip
RUN unzip /SickRage.zip
RUN rm -f /SickRage.zip

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
