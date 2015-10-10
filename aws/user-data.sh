#!/bin/bash
set -e -x

sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo yum install -y git

git clone https://github.com/wmarinho/edw_cenipa.git
cd edw_cenipa
sh ./install.sh

