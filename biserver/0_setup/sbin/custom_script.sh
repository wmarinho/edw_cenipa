#!/bin/bash
set -e -x
echo "Setting jdbc properties"
STG_DB=stg_cenipa
EDW_DB=edw_cenipa

cat <<EOF > ${PENTAHO_HOME}/biserver-ce/pentaho-solutions/system/simple-jndi/jdbc.properties
${STG_DB}/type=javax.sql.DataSource
${STG_DB}/driver=org.postgresql.Driver
${STG_DB}/url=jdbc:postgresql://${EDW_DB_PORT_5432_TCP_ADDR}:5432/${STG_DB}
${STG_DB}/user=${PGUSER}
${STG_DB}/password=${PGPASSWORD}

${EDW_DB}/type=javax.sql.DataSource
${EDW_DB}/driver=org.postgresql.Driver
${EDW_DB}/url=jdbc:postgresql://${EDW_DB_PORT_5432_TCP_ADDR}:5432/${EDW_DB}
${EDW_DB}/user=${PGUSER}
${EDW_DB}/password=${PGPASSWORD}
EOF

if [ ${CUSTOM_LAYOUT} ]; then
   cp -r ${PENTAHO_HOME}/config/layout/* ${PENTAHO_HOME}/biserver-ce/pentaho-solutions/system/
fi

