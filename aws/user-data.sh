#!/bin/bash
set -e -x

yum update -y
yum install -y docker
service docker start
usermod -a -G docker ec2-user
yum install -y git


pip install -U docker-compose
git clone https://github.com/wmarinho/edw_cenipa.git
cd edw_cenipa
sh ./install.sh

