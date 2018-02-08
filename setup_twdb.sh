#!/bin/bash

source ~/.sandbox.conf.sh

echo "Provisioning!"

cat /etc/hosts /vagrant/data/hosts >/tmp/newhosts
sudo cp /tmp/newhosts /etc/hosts
cat /etc/hosts

sudo apt-get update
sudo apt-get --yes install curl
sudo apt-get --yes install postgresql postgresql-contrib
sudo apt-get --yes install sysvbanner

echo "Setting-up time synchronisation"
sudo timedatectl set-ntp false
sudo cp  /vagrant/data/timesyncd.conf /etc/systemd/timesyncd.conf
sudo apt-get --yes install ntp
sudo timedatectl set-ntp true

# Note: You may need to change the ip address range below.
#
sudo sed -i.bak "s/# - Connection Settings -/listen_addresses = '*'/g" /etc/postgresql/9.5/main/postgresql.conf
sudo echo "host all all * md5" >> /tmp/pg_hba.conf2
sudo echo "host all all 192.168.0.0/16 md5" >> /tmp/pg_hba.conf2
sudo cat /etc/postgresql/9.5/main/pg_hba.conf /tmp/pg_hba.conf2 >/tmp/pg_hba.conf3
sudo cp /tmp/pg_hba.conf3 /etc/postgresql/9.5/main/pg_hba.conf

sudo update-rc.d postgresql enable
sudo service postgresql restart

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

sudo su postgres -c "psql --file=/tmp/psql.psq"
rm /tmp/psql.psq


banner "PSQL done"


echo "########################"
echo "## Installing agent 5 ##"
echo "########################"

echo "Installing dd-agent from api_key: ${DD_API_KEY}..."
DD_API_KEY=${DD_API_KEY} DD_INSTALL_ONLY=true bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh)"

echo "Adding Postgres Check to dd-agent"
sudo cp /vagrant/data/postgres.yaml /etc/dd-agent/conf.d/postgres.yaml
sudo sed -i.bak "s/# hostname: mymachine.mydomain/hostname: ${HOSTNAME_BASE}.twdb/g" /etc/dd-agent/datadog.conf
sudo sed -i.bak "s/# tags: mytag, env:prod, role:database/tags: ${TAG_DEFAULTS},tester:basic_agent_setup/g" /etc/dd-agent/datadog.conf
sudo sed -i.bak "s/# apm_enabled: false/apm_enabled: true/g" /etc/dd-agent/datadog.conf
sudo rm /etc/dd-agent/datadog.conf.bak

sudo /etc/init.d/datadog-agent start
