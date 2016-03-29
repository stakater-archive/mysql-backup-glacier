############################################################
# Dockerfile to store the mysql backup on amazon glacier storage
############################################################

FROM stakater/base:latest
MAINTAINER Atif Saddique <atif@aurorasolutions.io>


# Update aptitude with new repo
RUN apt-get update

# Install software 
RUN apt-get install -y tar python python-pip

# Install Amazon Glacier cmd
RUN git clone https://github.com/uskudnik/amazon-glacier-cmd-interface.git

COPY glacier-cmd.conf /etc/glacier-cmd.conf

RUN cd amazon-glacier-cmd-interface && \
    python setup.py install

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY backup_glacier.py /home/backup_glacier.py
ADD pliro_cron /etc/cron.d/pliro_cron
RUN chmod +x /etc/cron.d/pliro_cron && \
    chmod +x /home/backup_glacier.py


CMD ["/usr/bin/supervisord"]


