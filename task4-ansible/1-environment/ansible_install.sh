#!/bin/bash
yum update
yum install curl git

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user

python3 -m pip install --user ansible paramiko docker-compose boto3 botocore

ansible-galaxy collection install amazon.aws
ansible-galaxy collection install community.docker

# Install docker compose
#sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

git clone https://github.com/AVShutov/internship