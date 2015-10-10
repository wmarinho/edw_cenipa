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

* Instalar Docker v1.7.1

  CentOS: https://docs.docker.com/installation/centos/

  Ubuntu: https://docs.docker.com/installation/ubuntulinux/

  Max : https://docs.docker.com/installation/mac/

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

### Acessar Dashboard

![](http://localhost/pentaho/plugin/cenipa/api/ocorrencias)

## Demo

![](https://raw.githubusercontent.com/wmarinho/edw_cenipa/master/demo/cenipa-demo.gif)





