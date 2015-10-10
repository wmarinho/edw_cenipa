#!/bin/bash
catalogo="Ocorrencias Aeronauticas"
ds="edw_cenipa"
host="edw_biserver"
login="admin"
password="password"
port="8080"
schema_path="/opt/edw_cenipa/3_schema/cenipa/cenipa.mondrian.xml"

cmd_publisher=$(curl -v -include --user ${login}:${password} -F "catalogName=${catalogo}" -F "overwrite=true"  -F "xmlaEnabledFlag=true" -F "parameters=DataSource=${ds}" -F "uploadAnalysis=@${schema_path}" http://${host}:${port}/pentaho/plugin/data-access/api/mondrian/postAnalysis)
echo ${cmd_publisher}
