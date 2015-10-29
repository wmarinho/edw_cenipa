#!/bin/bash
set -e -x

yum update -y
yum install -y docker
service docker start
usermod -a -G docker ec2-user
yum install -y git


pip install -U docker-compose
PATH=$PATH:/usr/local/bin

wget -O - https://raw.githubusercontent.com/wmarinho/edw_cenipa/master/easy_install | sh
