#!/bin/bash
 apt-get -y install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

echo "deb [arch=armhf] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | \
tee /etc/apt/sources.list.d/docker.list

apt update

apt-get -y install docker-ce

pip install docker-compose
