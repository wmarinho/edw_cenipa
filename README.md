# EDW CENIPA 
## Modelo BI open source para construção de um data warehouse com dados abertos do CENIPA

EDW CENIPA é um projeto open source, criado para prover análises dinâmicas de ocorrências aeronáuticas, ocorridas na aviação civil brasileira. O projeto utiliza técnicas e ferramentas de BI, explorando tecnologias inovadoras e de baixo custo. Historicamente, plataformas de Business Intelligence são caras e inviáveis para pequenos projetos. Esses projetos exigem qualificação especializada e custos altos de desenvolvimento. Este trabalho tem a pretensão de quebrar um pouco esta barreira. O que não significa pouca dedicação, empenho e esforço. 

Todas as análises têm como base os dados abertos fornecidos pelo CENIPA, com histórico de ocorrências nos últimos 10 anos ( http://dados.gov.br/dataset/ocorrencias-aeronauticas-da-aviacao-civil-brasileira). Os gráficos foram inspirados no relatório disponibilizado no link http://www.cenipa.aer.mil.br/cenipa/index.php/estatisticas/estatisticas/panorama.

Seguem alguns serviços, ferramentas e plataformas que foram utilizados para construir e testar este ambiente.
 
* Amazon Web Services - https://aws.amazon.com/ - Serviços de infraestrutura de nuvem
* Sistema Operacional Linux - CentOS 6 / Ubuntu 14
* Docker - https://www.docker.com/ - Plataforma aberta para construir e rodar aplicações distribuídas.
* Pentaho - http://www.pentaho.com/ e  http://community.pentaho.com/ - Plataforma open source de Big Data, Data Integration e Business Analytics

## Screenshot
### Visão geral das Ocorrências
![](https://raw.githubusercontent.com/wmarinho/edw_cenipa/master/demo/RxCwvo8.png)

## Instalação

### Requisitos

* Sistema Operacional com 2GB de RAM
* Instalar Docker v1.7.1

  CentOS: https://docs.docker.com/installation/centos/

  Ubuntu: https://docs.docker.com/installation/ubuntulinux/

  Mac : https://docs.docker.com/installation/mac/

* Instalar Docker Compose v1.4.2 - https://docs.docker.com/compose/install/
```
curl -L https://github.com/docker/compose/releases/download/1.4.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

* Instalar o GIT

https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

### Clone do repositório do Projeto

```
git clone https://github.com/wmarinho/edw_cenipa.git
cd edw_cenipa
sh install.sh
```

### Verificar execução dos containers
```
$ docker ps

CONTAINER ID        IMAGE                          COMMAND                CREATED             STATUS              PORTS                    NAMES
29bd63632c21        image_cenipa/biserver:latest   "sh scripts/run.sh"    2 hours ago         Up 2 hours          0.0.0.0:80->8080/tcp     edwcenipa_biserver_1
53b84cbc80e4        image_cenipa/pdi:latest        "./run.sh"             2 hours ago         Up 2 hours          8181/tcp                 edwcenipa_pdi_1
7787dcfe49df        wmarinho/postgresql:9.3        "/usr/lib/postgresql   2 hours ago         Up 2 hours          0.0.0.0:5432->5432/tcp   edwcenipa_db_1
```

O projeto possui 3 containers especificados no arquivo docker-compose.yml:

* edwcenipa_db_1 - Container com Banco de Dados PostgreSQL
* edwcenipa_pdi_1 - Container com instlação do Pentaho Data Integrator (Kettle) para download e carga dados para o DW
* edwcenipa_biserver_1 - Container com instalação do Pentaho Business Analytics (BI Server)

### Verificar logs do PDI e do BI Server

```
docker logs -f edwcenipa_pdi_1
docker logs -f edwcenipa_biserver_1
```

### Acessar Dashboard

http://localhost/pentaho/plugin/cenipa/api/ocorrencias


## Demo

![](https://raw.githubusercontent.com/wmarinho/edw_cenipa/master/demo/cenipa-demo.gif)





