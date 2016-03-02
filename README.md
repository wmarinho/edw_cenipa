# EDW CENIPA 
## BI open source template to build a scalable data warehouse with open data provided by CENIPA

EDW CENIPA  is an opensource project designed to enable analysis of aeronautical incidentes that occured in the brazilian civil aviation. The project uses techniques and BI tools that explore innovative low-cost technologies. Historically, Business Intelligence platforms are expensive and impracticable for small projects. BI projects require specialized skills and high development costs. This work aims to break this barrier.

All analyzes are based on open data provided by CENIPA with historical events of the last 10 years:

http://dados.gov.br/dataset/ocorrencias-aeronauticas-da-aviacao-civil-brasileira

The graphics were inspired by the report available on the link:
http://www.cenipa.aer.mil.br/cenipa/index.php/estatisticas/estatisticas/panorama

Here are some resources, tools and platforms that were used to develop and deploy the project

* Amazon Web Services - https://aws.amazon.com/ 
* Linux Operating System - CentOS 6 / Ubuntu 14
* GitHub - https://github.com/ - Powerful collaboration, code review, and code management foropen source and private projects
* Docker - https://www.docker.com/ - An open platform for distributed applications for developers and sysadmins.
* Pentaho - http://www.pentaho.com/ e http://community.pentaho.com/ - Big data integration and analytics solutions.

## Screenshot
### Overview
![](https://raw.githubusercontent.com/wmarinho/edw_cenipa/master/demo/RxCwvo8.png)

## Instalation

### Requirements

* Linux Operating System 4GB RAM and 10GB available hard disk space
* Install Docker v1.7.1
** CentOS: https://docs.docker.com/installation/centos/
** Ubuntu: https://docs.docker.com/installation/ubuntulinux/
** Mac : https://docs.docker.com/installation/mac/
* Install Docker Compose v1.4.2 - https://docs.docker.com/compose/install/

```
curl -L https://github.com/docker/compose/releases/download/1.4.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

* Install o GIT

https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

### Installation from source

```
git clone https://github.com/wmarinho/edw_cenipa.git
cd edw_cenipa
sh install.sh
```
or

### Fast install on CentOS

```
yum update -y
yum install -y docker
service docker start
usermod -a -G docker ec2-user
yum install -y git

pip install -U docker-compose
PATH=$PATH:/usr/local/bin
wget -O - https://raw.githubusercontent.com/wmarinho/edw_cenipa/master/easy_install | sh
```

### Fast install on Ubuntu Server 14.04

```
sudo wget https://raw.githubusercontent.com/it4biz/ubuntu-docker-installer/master/ubuntu-docker-installer.sh
sudo sh ubuntu-docker-installer.sh
```



### Check if containers are running
```
$ docker ps

CONTAINER ID        IMAGE                          COMMAND                CREATED             STATUS              PORTS                    NAMES
29bd63632c21        image_cenipa/biserver:latest   "sh scripts/run.sh"    2 hours ago         Up 2 hours          0.0.0.0:80->8080/tcp     edwcenipa_biserver_1
53b84cbc80e4        image_cenipa/pdi:latest        "./run.sh"             2 hours ago         Up 2 hours          8181/tcp                 edwcenipa_pdi_1
7787dcfe49df        wmarinho/postgresql:9.3        "/usr/lib/postgresql   2 hours ago         Up 2 hours          0.0.0.0:5432->5432/tcp   edwcenipa_db_1
```

The project has 3 containers :

* edwcenipa_db_1 – PostgreSQL database container
* edwcenipa_pdi_1 – Pentaho Data Integration container
* edwcenipa_biserver_1 – Pentaho BI Server container


### Check PDI and BI Server logs

```
docker logs -f edwcenipa_pdi_1
docker logs -f edwcenipa_biserver_1
```

Installation can take over 30 minutes , depending of server configuration and Internet bandwidth . 

With the following command and the appropriate credentials , you can run the project on Amazon Web Services. REMEMBER to replace the variables before running the command (check the parameters in the AWS console) . 

```
aws ec2 run-instances --image-id ami-e3106686 --instance-type c4.large --subnet-id ${SUBNET_ID} --security-group-ids ${SGROUP_IDS}  --key-name ${KEY_NAME} --associate-public-ip-address --user-data "https://raw.githubusercontent.com/wmarinho/edw_cenipa/master/aws/user-data.sh" --count 1
```
The command above require AWS CLI (https://aws.amazon.com/pt/cli/) and AWS credentials (``` aws configure ```).

### Dashboard URL

http://localhost/pentaho/plugin/cenipa/api/ocorrencias

login: Admin

Senha: password


## Demo

![](https://raw.githubusercontent.com/wmarinho/edw_cenipa/master/demo/cenipa-demo.gif)

## Slideshare

[Building a data warehouse with Pentaho and Docker](http://pt.slideshare.net/wmarinho/building-a-data-warehouse-with-pentaho-and-docker-58940969)

##Docker Commands
sudo docker-compose up -d<BR>
docker-compose start<BR>


