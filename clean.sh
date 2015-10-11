#!/bin/bash

UNTAGGED_IMG=$(docker images -q --filter "dangling=true")
if [ "${UNTAGGED_IMG}" ]; then
   docker rmi ${UNTAGGED_IMG}
fi
CONTAINER_ID=$(docker ps -qs)
docker rm ${CONTAINER_ID}
