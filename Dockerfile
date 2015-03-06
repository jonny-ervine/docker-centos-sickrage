# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates, and pre-requisites for SickRage
RUN yum update -y; yum clean all
RUN yum install -y python-cheetah unzip

# Download and extract the latest SickRage release
RUN curl -L https://github.com/SiCKRAGETV/SickRage/archive/master.zip -o /SickRage.zip
RUN unzip /SickRage.zip
RUN rm -f /SickRage.zip

VOLUME /config
VOLUME /downloads

# Start sshd
EXPOSE 8081
ENTRYPOINT ["/SickRage-master/SickBeard.py", "--config=/config/config.ini"]
