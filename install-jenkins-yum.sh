#!bin/bash

# script to install docker engine and jenkins using yum package manager

echo 'Starting script to install docker engine and jenkins ....'
# 1 . Install docker
sudo rpm --import "https://sks-keyservers.net/pks/lookup?op=get&search=0xee6d536cf7dc86e2d7d56f59a178ac6c6238f52e"
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://packages.docker.com/1.12/yum/repo/main/centos/7
sudo yum makecache fast
sudo yum install docker-engine

echo 'Configuring Docker daemon service'
# 1.1 Docker daemon config
sudo systemctl enable docker.service
sudo systemctl start docker.service

# 1.2 Adding the non-root users to docker service
sudo usermod -a -G docker ec2-user

echo 'Runing jenkins docker image'
# 2 . Run Jenkins

mkdir -p /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home/
docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -d --name jenkins jenkins


# show endpoint
echo 'Jenkins installed'
echo 'To access to jenkins site use: http://'$(curl -s ifconfig.co)':8080'
