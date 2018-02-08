#!/bin/bash
# ET_DATABASE_LOCATION=${ET_DATABASE_LOCATION:-'localhost:27017'}

echo "Running docker-entrypoint.sh postgres &" 
docker-entrypoint.sh postgres & 

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_INSTALL_ONLY=true bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh)"

echo "Adding Postgres Check to dd-agent"
cp /postgres.yaml /etc/dd-agent/conf.d/postgres.yaml
echo "Updating datadog.conf x3"
sed -i.bak "s/# hostname: mymachine.mydomain/hostname: ${HOSTNAME_BASE}.twdb/g" /etc/dd-agent/datadog.conf
sed -i.bak "s/# tags: mytag, env:prod, role:database/tags: ${TAG_DEFAULTS},tester:basic_agent_setup/g" /etc/dd-agent/datadog.conf
sed -i.bak "s/# apm_enabled: false/apm_enabled: true/g" /etc/dd-agent/datadog.conf
rm /etc/dd-agent/datadog.conf.bak

echo "Starting the DD agent"
/etc/init.d/datadog-agent restart


# echo "Starting postgres"
# su postgres -c "pg_ctl -D /var/lib/postgresql/data -l logfile start"

echo "Creating the role and the table in postgres and granting access"
cat <<EOT >>/tmp/psql.psq
create role ddload login password 'ddload';
CREATE SCHEMA test;
GRANT ALL ON SCHEMA test TO ddload;
create table test.consumecpu (result varchar(128));
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA test
TO ddload;
create user datadog with password 'iXqadU3qIZpyYCYEessha7KZ';
grant SELECT ON pg_stat_database to datadog;
EOT

su postgres -c "psql --file=/tmp/psql.psq"
rm /tmp/psql.psq

