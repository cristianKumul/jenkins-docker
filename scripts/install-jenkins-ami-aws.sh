#!bin/bash

# script to install docker engine and jenkins using yum package manager

echo 'Starting script to install docker engine and jenkins ....'
# 1 . Install docker
sudo yum update -y
sudo yum install -y docker

echo 'Configuring Docker daemon service'
# 1.1 Docker daemon config
sudo service docker start

# 1.2 Adding the non-root users to docker service
sudo usermod -a -G docker ec2-user

echo 'Runing jenkins docker image'
# 2 . Run Jenkins

sudo mkdir -p /var/jenkins_home
sudo chown -R 1000:1000 /var/jenkins_home/
docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -d --name jenkins jenkins


# show endpoint
echo 'Jenkins installed'
echo 'You should now be able to access jenkins at: http://'$(curl -s ifconfig.co)':8080'
