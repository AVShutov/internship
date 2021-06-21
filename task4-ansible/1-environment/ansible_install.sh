#!/bin/bash
yum update
yum install curl git

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user

python3 -m pip install --user ansible paramiko docker 'docker-compose>= 1.7.0' requests boto3 botocore
#python3 -m pip install --user paramiko
#python3 -m pip install --user docker
#python3 -m pip install --user docker-compose
#python3 -m pip install --user requests
#boto3
#botocore

ansible-galaxy collection install amazon.aws

# Install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose