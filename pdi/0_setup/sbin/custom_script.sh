#!/bin/bash

AWS_S3_STAGE=s3://edw_cenipa/stage-template
EDW_HOME=/opt/edw_cenipa
DM_PATH=
STG_DB=stg_cenipa
EDW_DB=edw_cenipa

if [ "${DM}" ]; then
	DM_PATH=${DM}
fi

LOCAL_S3_STAGE=${EDW_HOME}/stage/${DM_PATH}

if [ "${EDW_DB_PORT_5432_TCP_ADDR}" ]; then
   PGHOST="${EDW_DB_PORT_5432_TCP_ADDR}"
fi

if [ "$RDS_HOSTNAME" ]; then
	PGHOST="$RDS_HOSTNAME"
	PGUSER="$RDS_USERNAME"
	PGPASSWORD="$RDS_PASSWORD"
	PGDATABASE="$RDS_DB_NAME"
	PGPORT="$RDS_PORT"
fi

cat <<EOF > /opt/pentaho/data-integration/simple-jndi/jdbc.properties
${STG_DB}/type=javax.sql.DataSource
${STG_DB}/driver=org.postgresql.Driver
${STG_DB}/url=jdbc:postgresql://${PGHOST}:5432/${STG_DB}
${STG_DB}/user=${PGUSER}
${STG_DB}/password=${PGPASSWORD}

${EDW_DB}/type=javax.sql.DataSource
${EDW_DB}/driver=org.postgresql.Driver
${EDW_DB}/url=jdbc:postgresql://${PGHOST}:5432/${EDW_DB}
${EDW_DB}/user=${PGUSER}
${EDW_DB}/password=${PGPASSWORD}
EOF

export PGPASSWORD="${PGPASSWORD}"; 

PG_CONN="-U ${PGUSER}  -h ${PGHOST}"
CHK_STG_DB=`echo "$(psql ${PG_CONN} -d ${STG_DB} -l | grep ${STG_DB} | wc -l)"`
CHK_EDW_DB=`echo "$(psql ${PG_CONN} -d ${EDW_DB} -l | grep ${EDW_DB} | wc -l)"`

if [ "$CHK_STG_DB" -eq "0" ]; then
   echo $(psql ${PG_CONN} -d postgres --command "CREATE DATABASE ${STG_DB};")
fi

if [ "$CHK_EDW_DB" -eq "0" ]; then
   echo $(psql ${PG_CONN} -d postgres --command "CREATE DATABASE ${EDW_DB};")
fi

echo $(psql ${PG_CONN} -d ${STG_DB} -f ${EDW_HOME}/0_setup/db/${STG_DB}.sql)
echo $(psql ${PG_CONN} -d ${EDW_DB} -f ${EDW_HOME}/0_setup/db/${EDW_DB}.sql)

mkdir -p ${LOCAL_S3_STAGE}

# Get files from S3
aws s3 sync ${AWS_S3_STAGE} ${LOCAL_S3_STAGE}

# Run job
sh kitchen.sh -rep=edw_cenipa -job=/base/3_cargas/job_carga_base -level=Basic
sh kitchen.sh -rep=edw_cenipa -job=/cenipa/3_cargas/job_carga_cenipa -level=Basic

echo $(psql ${PG_CONN} -d ${EDW_DB} -f ${EDW_HOME}/0_setup/db/${EDW_DB}_idx.sql)
