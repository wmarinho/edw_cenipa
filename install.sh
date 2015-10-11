#!/bin/bash
OPT=$1
INSTALL_DIR=`pwd`
PDI_BUILD=${INSTALL_DIR}/pdi
BISERVER_BUILD=${INSTALL_DIR}/biserver
RUN_STACK="docker-compose up -d"

hash docker &> /dev/null
if [ $? -eq 1 ]; then
    echo >&2 "docker not found. Please check https://docs.docker.com/installation/"
    exit 1
fi

hash docker-compose &> /dev/null
if [ $? -eq 1 ]; then
    echo >&2 "docker-compose not found. Please check https://docs.docker.com/compose/install/"
    exit 1
fi

cd ${PDI_BUILD} && sh ${PDI_BUILD}/build.sh
cd ${BISERVER_BUILD} && sh ${BISERVER_BUILD}/build.sh
cd ${INSTALL_DIR}

exec ${RUN_STACK}


