
# docker-centos-sickrage
## SickRage running on the latest CentOS docker image (7.3)
## Build Version: 7.3
Date of Build: 10th July 2017

The Dockerfile should intialise the CentOS image and subscribe to the EPEL repository. The pre-requisites for SickRage are then installed via yum.

The EPEL repository provides:

    python-cheetah supervisor

The SickRage daemon is controlled via the supervisord daemon which has a web front end exposed via port 9003. Default username and password for the web front end is admin:admin.

The SickRage software package is downloaded as a zip file from github and then extracted into the docker container ready for use.

The container can be run as follows:

    docker pull jervine/docker-centos-sickrage
    docker run -d -n <optional name of container> -h <optional host name of container> -e USER="<user account to run as> -e USERUID="<uid of user account"> -e TZ="<optional timezone> -v /<config directory on host>:/config/sickrage -v /<download directory on host>:/downloads -p 8081:8081 -p 9003:9003 jervine/docker-centos-sickrage

The USER and USERUID variables will be used to create an unprivileged account in the container to run the Sickrage under. The startup.sh script will create this user and also inject the username into the user= parameter of the sickrage.ini supervisor file.

THe TZ variable allows the user to set the correct timezone for the container and should take the form "Europe/London". If no timezone is specified then UTC is used by default. The timezone is set up when the container is run. Subsequent stops and starts will not change the timezone.

If the container is removed and is set up again using docker run commands, remember to remove the .setup file so that the start.sh script will recreate the user account and set the local time correctly.

The container can be verified on the host by using:

    docker logs <container id/container name>
and/or:

    cat /<config directory on host>/Logs/sickrage.log

Please note that the SELinux permissions of the config and downloads directories may need to be changed/corrected as necessary. [Currently chcon -Rt svirt_sandbox_file_t ]
