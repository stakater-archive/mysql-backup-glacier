############################################################
# Dockerfile to store the mysql backup on amazon glacier storage
############################################################

FROM mysql:5.7
MAINTAINER Atif Saddique <atif@aurorasolutions.io>


# Update aptitude with new repo
RUN apt-get update

# Install software 
RUN apt-get install -y vim git tar python python-pip cron

# Install Amazon Glacier cmd
RUN git clone https://github.com/uskudnik/amazon-glacier-cmd-interface.git

ADD glacier-cmd.conf /etc/glacier-cmd.conf

RUN cd amazon-glacier-cmd-interface && \
    python setup.py install

ADD backup_glacier.py /home/backup_glacier.py
ADD pliro_cron /etc/cron.d/pliro_cron

RUN touch /var/log/cron.log

RUN chmod +x /etc/cron.d/pliro_cron && \
    chmod +x /home/backup_glacier.py


CMD cron && /bin/bash

