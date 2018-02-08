#!/bin/bash

source ~/.sandbox.conf.sh

echo "Provisioning! $0 running."

cat /etc/hosts /vagrant/data/hosts >/tmp/newhosts
sudo cp /tmp/newhosts /etc/hosts
cat /etc/hosts

sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

sudo apt-get update
sudo apt-get --yes install curl
sudo apt-get --yes install default-jdk python-pip maven sysvbanner tomcat8


echo "Setting-up time synchronisation"
sudo timedatectl set-ntp false
sudo cp  /vagrant/data/timesyncd.conf /etc/systemd/timesyncd.conf
sudo apt-get --yes install ntp
sudo timedatectl set-ntp true

echo "Installing Tomcat"

sudo apt-get install -y tomcat8
echo "Stopping Tomcat"
sudo systemctl stop tomcat8

echo "Configuring Tomcat directories for log agent access"
sudo chmod +x /var/log/tomcat8
#
# sudo cp /vagrant/TimeWasterUI.war /var/lib/tomcat8/webapps
echo "Creating /var/lib/tomcat8/bin"
sudo mkdir /var/lib/tomcat8/bin
echo "Copying the file across and changing the mode"
sudo cp /vagrant/data/setenv_twui.sh /usr/share/tomcat8/bin/setenv.sh
sudo chmod +x /usr/share/tomcat8/bin/setenv.sh

sudo cp /vagrant/data/TimeWasterUI.war /var/lib/tomcat8/webapps/
sudo cp /vagrant/data/TimeWasterUI.properties /var/lib/tomcat8/webapps/
# sudo systemctl restart tomcat8


echo "########################"
echo "## Installing agent 6 ##"
echo "########################"
banner "Agent 6.."

DD_API_KEY=${DD_API_KEY} bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
sudo sed -i.bak "s/# hostname: mymachine.mydomain/hostname: ${HOSTNAME_BASE}.twui/g" /etc/datadog-agent/datadog.yaml
sudo sed -i.bak "s/# tags:/tags: ${TAG_DEFAULTS},tester:basic_agent_setup/g" /etc/datadog-agent/datadog.yaml
sudo sed -i.bak "s/# log_enabled: false/log_enabled: true/g" /etc/datadog-agent/datadog.yaml
sudo sed -i.bak "s/tags: /tags: solution:timewaster,/g" /etc/datadog-agent/datadog.yaml

# hostname: mymachine.mydomain
echo "Pulling java agent from the web"
wget -O dd-java-agent.jar 'https://search.maven.org/remote_content?g=com.datadoghq&a=dd-java-agent&v=LATEST'

echo "Copy the agent to /usr/share/tomcat8/lib/dd-java-agent.jar"
sudo cp dd-java-agent.jar /usr/share/tomcat8/lib/dd-java-agent.jar
# echo "Pulling the Datadog Java Agent"
# cd /opt/tomcat/lib
# wget -O dd-java-agent.jar 'https://search.maven.org/remote_content?g=com.datadoghq&a=dd-java-agent&v=LATEST'
echo "Done for the DD java agent"

echo "########################"
echo "## Finished  agent 6  ##"
echo "########################"
banner "agent 6 OK"

echo "TWUI ... Starting tomcat 8"
sudo systemctl restart tomcat8

ip a
