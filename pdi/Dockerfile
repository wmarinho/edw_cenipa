FROM wmarinho/pentaho-kettle:latest

MAINTAINER Wellington Marinho wpmarinho@globo.com

ENV PENTAHO_HOME /opt/pentaho
ENV EDW_HOME /opt/edw_cenipa

USER root
RUN apt-get update && apt-get install locales -y; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p ${EDW_HOME}  && chown  pentaho:pentaho  ${EDW_HOME}

ENV TIMEZONE "America/Sao_Paulo"

RUN echo $TIMEZONE > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

USER pentaho

COPY 0_setup/sbin/ ${PENTAHO_HOME}/data-integration
COPY 1_config ${EDW_HOME}/1_config
COPY 1_config/.kettle ${PENTAHO_HOME}/.kettle/
COPY 0_setup ${EDW_HOME}/0_setup
COPY 2_etl ${EDW_HOME}/2_etl
COPY 3_schema ${EDW_HOME}/3_schema


