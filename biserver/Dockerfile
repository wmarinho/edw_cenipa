FROM wmarinho/pentaho-biserver:latest

MAINTAINER Wellington Marinho wpmarinho@globo.com

ENV PENTAHO_HOME /opt/pentaho

COPY 0_setup/sbin/ ${PENTAHO_HOME}

COPY 1_config/.kettle ${PENTAHO_HOME}/.kettle
COPY 1_config/ ${PENTAHO_HOME}/config
COPY 3_plugins/ ${PENTAHO_HOME}/biserver-ce/pentaho-solutions/system
COPY 2_schema/ ${PENTAHO_HOME}/schema

USER root
RUN apt-get update; apt-get install zip -y
RUN chown -R pentaho:pentaho ${PENTAHO_HOME}
USER pentaho
