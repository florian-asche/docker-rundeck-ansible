# Ansible Agent - Docker Container with Ansible and SSHD-Server

![Build/Push (master)](https://github.com/florian-asche/docker-ansible-ssh/workflows/Build/Push%20(master)/badge.svg)

This is docker container with [Ansible](https://www.ansible.com/)' and a ssh-server.
This docker container can be used as ansible agent for example to use it with rundeck.

## Prerequisites

## Installation

### Using Docker

The container is available as a [Docker image](https://hub.docker.com/r/florian9931/docker-ansible-ssh).
You can run it using the following example and pass configuration environment variables:

```bash
$ docker run \
  -v ./path/to/your/authorized_keys:/home/ansible/.ssh/authorized_keys \
  -p 2022:22 \
  florian9931/ansible-ssh:latest
```

The authorized_keys needs to be chown 1500:1500. The File and the .ssh directory also needs to be chown 1500 and the chmod needs to be 700 on both, file and directory.

