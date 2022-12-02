# Add variable for rundeck version
ARG RUNDECK_VERSION=latest

FROM rundeck/rundeck:${RUNDECK_VERSION}
LABEL name="rundeck-ansible"
MAINTAINER Florian Asche "https://github.com/florian-asche"

# Run everything as root user
USER root

# No interative menu
ENV DEBIAN_FRONTEND noninteractive

# Install base packages
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y -qq --no-install-recommends install \
        apt-transport-https \
        locales \
        python3-pip \
        sudo \
        wget \
        curl \
        git \
        net-tools \
        iputils-ping \
        dnsutils \
        nmap \
        sshpass \
        openssh-server

# Setup the default user.
RUN groupadd --gid 1500 ansible
RUN useradd -rm -d /home/ansible -s /bin/bash -u 1500 -g ansible ansible
RUN echo 'ansible:ansible' | chpasswd

## Setup ssh directory
RUN mkdir -p /home/ansible/.ssh/
RUN chmod 700 /home/ansible/.ssh/
#COPY files/authorized_keys /home/ansible/.ssh/
#RUN chmod 700 /home/ansible/.ssh/authorized_keys
RUN chown ansible:ansible -R /home/ansible

# Install Ansible
RUN apt remove ansible \
    && apt --purge autoremove \
    && apt -y install software-properties-common \
    && apt-add-repository ppa:ansible/ansible \
    && apt-get -y update \
    && apt-get -y install ansible
RUN apt-get -qq clean
RUN ansible --version

# Install additional needed python packages
RUN pip install --no-cache-dir  --upgrade PyYAML Jinja2 httplib2 boto requests urllib3
